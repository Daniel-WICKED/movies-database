/*
Problema 4: Películas de cine.
Se desea crear un sitio web con información referente a las películas en cartel en las salas
de un cine cercano a la plaza de armas.
De cada película, se almacena una ficha con su título de distribución, su título original, su
género, el idioma original, si tiene subtítulos en español o no, los países de origen, el año
de la producción, la url del sitio web de la película, la duración (en horas y minutos), la
calificación (Apta todo público, +9 años, +15 años, +18 años), fecha de estreno en Santiago,
un resumen y un identificador de la película. De cada película interesa conocer la lista de
directores y el reparto, es decir para cada actor que trabaja, el nombre de todos los
personajes que interpreta. Además, interesa disponer de información sobre los directores y
actores que trabajan en cada película. De ambos, se conoce su nombre (que lo identifica)
y su nacionalidad. Además, se desea conocer la cantidad de películas en las que dirigieron
o actuaron. Tenga en cuenta que hay personas que cumplen los dos roles.
Los cines pueden tener más de una sala y cada semana cada uno de los cines envía la
cartelera para dicha semana, indicando de detalle de las funciones. Para cada función se
conoce el día de la semana y la hora de comienzo, y obviamente la sala y la película que
exhibe. De cada sala se sabe el nombre, un número que la identifica dentro del cine y la
cantidad de butacas que posee. De cada cine se conoce el nombre que lo identifica, su
dirección y teléfono para consultas. Algunos cines cuentan con promociones. Estas
promociones dependen de la función. (Ej. De lunes a jueves antes de las 18 50% de
descuento en la sala tal del cine tal para la película cual...La función del lunes a las 14 para
la película tal en la sala cual, no se cobra a los escolares con túnica... ) De cada promoción
se conoce una descripción y el descuento que aplica. Además del resumen de la película
que se incluye en la ficha interesa mostrar la opinión de las personas que vieron la película.
De cada opinión se conoce el nombre de la persona que la realiza, su edad, le fecha en
que registró su opinión, la calificación que le dio a la película (Obra Maestra, Muy Buena,
Buena, Regular, Mala) y el comentario propiamente dicho. A cada opinión se le asigna un
número que la identifica respecto de la película sobre la cual opina.
 */

#include <iostream>
#include <pqxx/pqxx>
#include <cstdlib>


using namespace std;
using namespace pqxx;

// Funciones auxiliares
// Función para limpiar la consola
void limpiarConsola() {
    system("clear");
}

void limpiarBuffer(){
    cin.clear();
    cin.ignore(numeric_limits<streamsize>::max(), '\n');
}
// Función para pausar la consola
void pausa() {
    cout << "Pulse Enter para continuar...";
    cin.get();

}

// Función para ejecutar una consulta SQL a la base de datos
void ejecutarConsulta(connection &c, const string &query) {
    try {
        nontransaction n(c);
        result r = n.exec(query);
        n.commit();
    } catch (const exception &e) {
        cerr << "Error al ejecutar la consulta SQL: " << e.what() << endl;
    }
}

// Funciones principales
// Función para establecer la conexión con la base de datos
connection conectar() {
    try {
        connection c("dbname = peliculas user = postgres password = 1234admin hostaddr = 127.0.0.1 port = 5432");
        if (c.is_open()) {
            cout << "Conexión exitosa con la base de datos: " << c.dbname() << endl;
            return c;
        } else {
            cout << "No se ha podido establecer conexión con la base de datos" << endl;
            cout << "Pulse Enter para salir del programa" <<endl;
            cin.get();
            throw runtime_error("Error de conexión con la base de datos");
        }
    } catch (const exception &e) {
        cerr << e.what() << endl;
        throw;
    }
    pausa();
}

// Función para crear las tablas necesarias en caso de que no existan previamente
void crearTablas(connection &c) {
    try {
        string query_peliculas = "CREATE TABLE IF NOT EXISTS Peliculas ("
                                "id_pelicula SERIAL PRIMARY KEY, "
                                "titulo_distribucion VARCHAR(100), "
                                "titulo_original VARCHAR(100), "
                                "genero VARCHAR(50), "
                                "idioma_original VARCHAR(50), "
                                "subtitulos_espanol BOOLEAN, "
                                "paises_origen TEXT[], "
                                "ano_produccion INTEGER, "
                                "url_sitio_web VARCHAR(200), "
                                "duracion INTERVAL, "
                                "calificacion VARCHAR(20), "
                                "fecha_estreno_santiago DATE, "
                                "resumen TEXT"
                                ");";
        ejecutarConsulta(c, query_peliculas);

        string query_directores = "CREATE TABLE IF NOT EXISTS Directores ("
                                "id_director SERIAL PRIMARY KEY, "
                                "nombre VARCHAR(100), "
                                "nacionalidad VARCHAR(50)"
                                ");";
        ejecutarConsulta(c, query_directores);

        string query_peliculas_directores = "CREATE TABLE IF NOT EXISTS Peliculas_Directores ("
                                          "id_pelicula INTEGER REFERENCES Peliculas(id_pelicula), "
                                          "id_director INTEGER REFERENCES Directores(id_director), "
                                          "PRIMARY KEY (id_pelicula, id_director)"
                                          ");";
        ejecutarConsulta(c, query_peliculas_directores);

        string query_actores = "CREATE TABLE IF NOT EXISTS Actores ("
                             "id_actor SERIAL PRIMARY KEY, "
                             "nombre VARCHAR(100), "
                             "nacionalidad VARCHAR(50)"
                             ");";
        ejecutarConsulta(c, query_actores);

        string query_personajes = "CREATE TABLE IF NOT EXISTS Personajes ("
                                 "id_personaje SERIAL PRIMARY KEY, "
                                 "nombre_personaje VARCHAR(100), "
                                 "id_actor INTEGER REFERENCES Actores(id_actor)"
                                 ");";
        ejecutarConsulta(c, query_personajes);

        string query_peliculas_actores = "CREATE TABLE IF NOT EXISTS Peliculas_Actores ("
                                        "id_pelicula INTEGER REFERENCES Peliculas(id_pelicula), "
                                        "id_actor INTEGER REFERENCES Actores(id_actor), "
                                        "id_personaje INTEGER REFERENCES Personajes(id_personaje), "
                                        "PRIMARY KEY (id_pelicula, id_actor)"
                                        ");";
        ejecutarConsulta(c, query_peliculas_actores);

        string query_cines = "CREATE TABLE IF NOT EXISTS Cines ("
                            "id_cine SERIAL PRIMARY KEY, "
                            "nombre VARCHAR(100), "
                            "direccion VARCHAR(200), "
                            "telefono VARCHAR(20)"
                            ");";
        ejecutarConsulta(c, query_cines);

        string query_salas = "CREATE TABLE IF NOT EXISTS Salas ("
                            "id_sala SERIAL PRIMARY KEY, "
                            "nombre VARCHAR(100), "
                            "numero INTEGER, "
                            "cantidad_butacas INTEGER, "
                            "id_cine INTEGER REFERENCES Cines(id_cine)"
                            ");";
        ejecutarConsulta(c, query_salas);

        string query_funciones = "CREATE TABLE IF NOT EXISTS Funciones ("
                                "id_funcion SERIAL PRIMARY KEY, "
                                "dia_semana VARCHAR(20), "
                                "hora_comienzo TIME, "
                                "id_sala INTEGER REFERENCES Salas(id_sala), "
                                "id_pelicula INTEGER REFERENCES Peliculas(id_pelicula)"
                                ");";
        ejecutarConsulta(c, query_funciones);

        string query_promociones = "CREATE TABLE IF NOT EXISTS Promociones ("
                                  "id_promocion SERIAL PRIMARY KEY, "
                                  "descripcion TEXT, "
                                  "descuento NUMERIC"
                                  ");";
        ejecutarConsulta(c, query_promociones);

        string query_funciones_promociones = "CREATE TABLE IF NOT EXISTS Funciones_Promociones ("
                                            "id_funcion INTEGER REFERENCES Funciones(id_funcion), "
                                            "id_promocion INTEGER REFERENCES Promociones(id_promocion), "
                                            "PRIMARY KEY (id_funcion, id_promocion)"
                                            ");";
        ejecutarConsulta(c, query_funciones_promociones);

        string query_opiniones = "CREATE TABLE IF NOT EXISTS Opiniones ("
                                "id_opinion SERIAL PRIMARY KEY, "
                                "id_pelicula INTEGER REFERENCES Peliculas(id_pelicula), "
                                "nombre_persona VARCHAR(100), "
                                "edad INTEGER, "
                                "fecha_registro TIMESTAMP, "
                                "calificacion VARCHAR(20), "
                                "comentario TEXT"
                                ");";
        ejecutarConsulta(c, query_opiniones);

        cout << "Tablas comprobadas exitosamente" << endl;
        system("sleep 1");
        cout << "Cargando menú principal..." << endl;
        system("sleep 2");
    } catch (const exception &e) {
        cerr << "Error al crear las tablas: " << e.what() << endl;
        pausa();
        throw;
        return;
    }
}

// Funciones para mostrar datos
void mostrarPeliculas(connection &c) {
    limpiarConsola();
    limpiarBuffer();    
    try {
        string query = "SELECT p.id_pelicula, p.titulo_distribucion, p.genero, p.idioma_original, p.subtitulos_espanol, "
                       "p.paises_origen, p.ano_produccion, p.calificacion, p.fecha_estreno_santiago, p.resumen, "
                       "d.nombre AS director "
                       "FROM Peliculas p "
                       "LEFT JOIN Peliculas_Directores pd ON p.id_pelicula = pd.id_pelicula "
                       "LEFT JOIN Directores d ON pd.id_director = d.id_director;";
        nontransaction N(c);
        result R(N.exec(query));

        if (R.size() == 0) {
            cout << "La tabla Peliculas está vacía." << endl;
            return;
        }

        cout << "Datos de la tabla Peliculas:" << endl;
        for (result::const_iterator row = R.begin(); row != R.end(); ++row) {
            cout << "ID: " << row["id_pelicula"].as<int>() << endl;
            cout << "Título: " << row["titulo_distribucion"].as<string>() << endl;
            cout << "Género: " << row["genero"].as<string>() << endl;
            cout << "Idioma original: " << row["idioma_original"].as<string>() << endl;
            cout << "Subtítulos en español: " << (row["subtitulos_espanol"].as<bool>() ? "Sí" : "No") << endl;
            cout << "Países de origen: " << row["paises_origen"].as<string>() << endl;
            cout << "Año de producción: " << row["ano_produccion"].as<int>() << endl;
            cout << "Calificación: " << row["calificacion"].as<string>() << endl;
            cout << "Fecha de estreno en Santiago: " << row["fecha_estreno_santiago"].as<string>() << endl;
            cout << "Resumen: " << row["resumen"].as<string>() << endl;
            cout << "Director: " << row["director"].as<string>() << endl;
            cout << endl;
        }
    } catch (const exception &e) {
        cerr << "Error al mostrar datos de la tabla Peliculas: " << e.what() << endl;
        throw;
    }
    pausa();
}

void mostrarDirectores(connection &c) {
    limpiarConsola();
    limpiarBuffer();
    try {
        string query = "SELECT * FROM Directores;";
        nontransaction N(c);
        result R(N.exec(query));

        if (R.size() == 0) {
            cout << "La tabla Directores está vacía." << endl;
            return;
        }

        cout << "Datos de la tabla Directores:" << endl;
        for (result::const_iterator row = R.begin(); row != R.end(); ++row) {
            cout << "ID: " << row["id_director"].as<int>() << endl;
            cout << "Nombre: " << row["nombre"].as<string>() << endl;
            cout << "Nacionalidad: " << row["nacionalidad"].as<string>() << endl;
            cout << endl;
        }
    } catch (const exception &e) {
        cerr << "Error al mostrar datos de la tabla Directores: " << e.what() << endl;
        throw;
    }
    pausa();
}

void mostrarActores(connection &c) {
    limpiarConsola();
    limpiarBuffer();
    try {
        string query = "SELECT * FROM Actores;";
        nontransaction N(c);
        result R(N.exec(query));

        if (R.size() == 0) {
            cout << "La tabla Actores está vacía." << endl;
            return;
        }

        cout << "Datos de la tabla Actores:" << endl;
        for (result::const_iterator row = R.begin(); row != R.end(); ++row) {
            cout << "ID: " << row["id_actor"].as<int>() << endl;
            cout << "Nombre: " << row["nombre"].as<string>() << endl;
            cout << "Nacionalidad: " << row["nacionalidad"].as<string>() << endl;
            cout << endl;
        }
    } catch (const exception &e) {
        cerr << "Error al mostrar datos de la tabla Actores: " << e.what() << endl;
        throw;
    }
    pausa();
}

void mostrarPersonajes(connection &c) {
    limpiarConsola();
    limpiarBuffer();
    try {
        string query = "SELECT pe.id_personaje, pe.nombre_personaje, a.nombre AS actor "
                       "FROM Personajes pe "
                       "LEFT JOIN Actores a ON pe.id_actor = a.id_actor;";
        nontransaction N(c);
        result R(N.exec(query));

        if (R.size() == 0) {
            cout << "La tabla Personajes está vacía." << endl;
            return;
        }

        cout << "Datos de la tabla Personajes:" << endl;
        for (result::const_iterator row = R.begin(); row != R.end(); ++row) {
            cout << "ID: " << row["id_personaje"].as<int>() << endl;
            cout << "Nombre: " << row["nombre_personaje"].as<string>() << endl;
            cout << "Actor: " << row["actor"].as<string>() << endl;
            cout << endl;
        }
    } catch (const exception &e) {
        cerr << "Error al mostrar datos de la tabla Personajes: " << e.what() << endl;
        throw;
    }
    pausa();
}

void mostrarCines(connection &c) {
    limpiarConsola();
    limpiarBuffer();
    try {
        string query = "SELECT * FROM Cines;";
        nontransaction N(c);
        result R(N.exec(query));

        if (R.size() == 0) {
            cout << "La tabla Cines está vacía." << endl;
            return;
        }

        cout << "Datos de la tabla Cines:" << endl;
        for (result::const_iterator row = R.begin(); row != R.end(); ++row) {
            cout << "ID: " << row["id_cine"].as<int>() << endl;
            cout << "Nombre: " << row["nombre"].as<string>() << endl;
            cout << "Dirección: " << row["direccion"].as<string>() << endl;
            cout << "Teléfono: " << row["telefono"].as<string>() << endl;
            cout << endl;
        }
    } catch (const exception &e) {
        cerr << "Error al mostrar datos de la tabla Cines: " << e.what() << endl;
        throw;
    }
    pausa();
}

void mostrarSalas(connection &c) {
    limpiarConsola();
    limpiarBuffer();
    try {
        string query = "SELECT sa.id_sala, sa.nombre, sa.numero, sa.cantidad_butacas, c.nombre AS cine "
                       "FROM Salas sa "
                       "LEFT JOIN Cines c ON sa.id_cine = c.id_cine;";
        nontransaction N(c);
        result R(N.exec(query));

        if (R.size() == 0) {
            cout << "La tabla Salas está vacía." << endl;
            return;
        }

        cout << "Datos de la tabla Salas:" << endl;
        for (result::const_iterator row = R.begin(); row != R.end(); ++row) {
            cout << "ID: " << row["id_sala"].as<int>() << endl;
            cout << "Nombre: " << row["nombre"].as<string>() << endl;
            cout << "Número: " << row["numero"].as<int>() << endl;
            cout << "Cantidad de butacas: " << row["cantidad_butacas"].as<int>() << endl;
            cout << "Cine: " << row["cine"].as<string>() << endl;
            cout << endl;
        }
    } catch (const exception &e) {
        cerr << "Error al mostrar datos de la tabla Salas: " << e.what() << endl;
        throw;
    }
    pausa();
}

void mostrarFunciones(connection &c) {
    limpiarConsola();
    limpiarBuffer();
    try {
        string query = "SELECT fu.id_funcion, fu.dia_semana, fu.hora_comienzo, sa.nombre AS sala, p.titulo_distribucion AS pelicula "
                       "FROM Funciones fu "
                       "LEFT JOIN Salas sa ON fu.id_sala = sa.id_sala "
                       "LEFT JOIN Peliculas p ON fu.id_pelicula = p.id_pelicula;";
        nontransaction N(c);
        result R(N.exec(query));

        if (R.size() == 0) {
            cout << "La tabla Funciones está vacía." << endl;
            return;
        }

        cout << "Datos de la tabla Funciones:" << endl;
        for (result::const_iterator row = R.begin(); row != R.end(); ++row) {
            cout << "ID: " << row["id_funcion"].as<int>() << endl;
            cout << "Día de la semana: " << row["dia_semana"].as<string>() << endl;
            cout << "Hora de comienzo: " << row["hora_comienzo"].as<string>() << endl;
            cout << "Sala: " << row["sala"].as<string>() << endl;
            cout << "Película: " << row["pelicula"].as<string>() << endl;
            cout << endl;
        }
    } catch (const exception &e) {
        cerr << "Error al mostrar datos de la tabla Funciones: " << e.what() << endl;
        throw;
    }
    pausa();
}

void mostrarPromociones(connection &c) {
    limpiarConsola();
    limpiarBuffer();
    try {
        string query = "SELECT * FROM Promociones;";
        nontransaction N(c);
        result R(N.exec(query));

        if (R.size() == 0) {
            cout << "La tabla Promociones está vacía." << endl;
            return;
        }

        cout << "Datos de la tabla Promociones:" << endl;
        for (result::const_iterator row = R.begin(); row != R.end(); ++row) {
            cout << "ID: " << row["id_promocion"].as<int>() << endl;
            cout << "Descripción: " << row["descripcion"].as<string>() << endl;
            cout << "Descuento: " << row["descuento"].as<double>() << endl;
            cout << endl;
        }
    } catch (const exception &e) {
        cerr << "Error al mostrar datos de la tabla Promociones: " << e.what() << endl;
        throw;
    }
    pausa();
}

void mostrarOpiniones(connection &c) {
    limpiarConsola();
    limpiarBuffer();
    try {
        string query = "SELECT * FROM Opiniones;";
        nontransaction N(c);
        result R(N.exec(query));

        if (R.size() == 0) {
            cout << "La tabla Opiniones está vacía." << endl;
            return;
        }

        cout << "Datos de la tabla Opiniones:" << endl;
        for (result::const_iterator row = R.begin(); row != R.end(); ++row) {
            cout << "ID: " << row["id_opinion"].as<int>() << endl;
            cout << "ID Película: " << row["id_pelicula"].as<int>() << endl;
            cout << "Nombre de la persona: " << row["nombre_persona"].as<string>() << endl;
            cout << "Edad: " << row["edad"].as<int>() << endl;
            cout << "Fecha de registro: " << row["fecha_registro"].as<string>() << endl;
            cout << "Calificación: " << row["calificacion"].as<string>() << endl;
            cout << "Comentario: " << row["comentario"].as<string>() << endl;
            cout << endl;
        }
    } catch (const exception &e) {
        cerr << "Error al mostrar datos de la tabla Opiniones: " << e.what() << endl;
        throw;
    }
    pausa();
}


// Menú para mostrar datos
void menuPrincipal(connection &c){
    int opcion;
    do {
        limpiarConsola();
        cout << "GESTIÓN DE PELÍCULAS" << endl;
        cout << "1. Mostrar Películas" << endl;
        cout << "2. Mostrar Directores" << endl;
        cout << "3. Mostrar Actores" << endl;
        cout << "4. Mostrar Personajes" << endl;
        cout << "5. Mostrar Cines" << endl;
        cout << "6. Mostrar Salas" << endl;
        cout << "7. Mostrar Funciones" << endl;
        cout << "8. Mostrar Promociones" << endl;
        cout << "9. Mostrar Opiniones" << endl;
        cout << "0. Salir del programa" << endl;
        cout << "Ingrese su opción: ";

        cin >> opcion;

        switch (opcion) {
            case 1: 
                mostrarPeliculas(c); 
                break;
            case 2: 
                mostrarDirectores(c); 
                break;
            case 3:
                mostrarActores(c); 
                break;
            case 4: 
                mostrarPersonajes(c); 
                break;
            case 5: 
                mostrarCines(c); 
                break;
            case 6: 
                mostrarSalas(c); 
                break;
            case 7: 
                mostrarFunciones(c); 
                break;
            case 8: 
                mostrarPromociones(c); 
                break;
            case 9: 
                mostrarOpiniones(c); 
                break;
            case 0:
                limpiarConsola();
                cout << "Programa finalizado..." << endl;
                system("sleep 1");
                break;
            default:
                limpiarConsola();
                cout << "Opción no válida, vuelva a intentarlo: " << endl;
                pausa();
                cin.clear();
                cin.ignore(numeric_limits<streamsize>::max(), '\n');
                break;
        }
    } while (opcion != 0);
}

// Función principal
int main() {
    limpiarConsola();
    try {
        connection c = conectar();
        system("sleep 1");
        crearTablas(c); 
        system("sleep 1");
        menuPrincipal(c);
    } catch (const exception &e) {
        cerr << "Error: " << e.what() << endl;
        return 1;
    }
    return 0;
}

