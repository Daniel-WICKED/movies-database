PGDMP     ;                     |        	   peliculas     15.3 (Ubuntu 15.3-1.pgdg22.04+1)     15.3 (Ubuntu 15.3-1.pgdg22.04+1) X    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    40674 	   peliculas    DATABASE     u   CREATE DATABASE peliculas WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es_CU.UTF-8';
    DROP DATABASE peliculas;
                postgres    false            �            1259    40828    actores    TABLE     �   CREATE TABLE public.actores (
    id_actor integer NOT NULL,
    nombre character varying(100),
    nacionalidad character varying(50)
);
    DROP TABLE public.actores;
       public         heap    postgres    false            �            1259    40827    actores_id_actor_seq    SEQUENCE     �   CREATE SEQUENCE public.actores_id_actor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.actores_id_actor_seq;
       public          postgres    false    220            �           0    0    actores_id_actor_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.actores_id_actor_seq OWNED BY public.actores.id_actor;
          public          postgres    false    219            �            1259    40867    cines    TABLE     �   CREATE TABLE public.cines (
    id_cine integer NOT NULL,
    nombre character varying(100),
    direccion character varying(200),
    telefono character varying(20)
);
    DROP TABLE public.cines;
       public         heap    postgres    false            �            1259    40866    cines_id_cine_seq    SEQUENCE     �   CREATE SEQUENCE public.cines_id_cine_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.cines_id_cine_seq;
       public          postgres    false    225            �           0    0    cines_id_cine_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.cines_id_cine_seq OWNED BY public.cines.id_cine;
          public          postgres    false    224            �            1259    40806 
   directores    TABLE     �   CREATE TABLE public.directores (
    id_director integer NOT NULL,
    nombre character varying(100),
    nacionalidad character varying(50)
);
    DROP TABLE public.directores;
       public         heap    postgres    false            �            1259    40805    directores_id_director_seq    SEQUENCE     �   CREATE SEQUENCE public.directores_id_director_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.directores_id_director_seq;
       public          postgres    false    217            �           0    0    directores_id_director_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.directores_id_director_seq OWNED BY public.directores.id_director;
          public          postgres    false    216            �            1259    40886 	   funciones    TABLE     �   CREATE TABLE public.funciones (
    id_funcion integer NOT NULL,
    dia_semana character varying(20),
    hora_comienzo time without time zone,
    id_sala integer,
    id_pelicula integer
);
    DROP TABLE public.funciones;
       public         heap    postgres    false            �            1259    40885    funciones_id_funcion_seq    SEQUENCE     �   CREATE SEQUENCE public.funciones_id_funcion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.funciones_id_funcion_seq;
       public          postgres    false    229            �           0    0    funciones_id_funcion_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.funciones_id_funcion_seq OWNED BY public.funciones.id_funcion;
          public          postgres    false    228            �            1259    40911    funciones_promociones    TABLE     r   CREATE TABLE public.funciones_promociones (
    id_funcion integer NOT NULL,
    id_promocion integer NOT NULL
);
 )   DROP TABLE public.funciones_promociones;
       public         heap    postgres    false            �            1259    40927 	   opiniones    TABLE       CREATE TABLE public.opiniones (
    id_opinion integer NOT NULL,
    id_pelicula integer,
    nombre_persona character varying(100),
    edad integer,
    fecha_registro timestamp without time zone,
    calificacion character varying(20),
    comentario text
);
    DROP TABLE public.opiniones;
       public         heap    postgres    false            �            1259    40926    opiniones_id_opinion_seq    SEQUENCE     �   CREATE SEQUENCE public.opiniones_id_opinion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.opiniones_id_opinion_seq;
       public          postgres    false    234            �           0    0    opiniones_id_opinion_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.opiniones_id_opinion_seq OWNED BY public.opiniones.id_opinion;
          public          postgres    false    233            �            1259    40797 	   peliculas    TABLE     �  CREATE TABLE public.peliculas (
    id_pelicula integer NOT NULL,
    titulo_distribucion character varying(100),
    titulo_original character varying(100),
    genero character varying(50),
    idioma_original character varying(50),
    subtitulos_espanol boolean,
    paises_origen text[],
    ano_produccion integer,
    url_sitio_web character varying(200),
    duracion interval,
    calificacion character varying(20),
    fecha_estreno_santiago date,
    resumen text
);
    DROP TABLE public.peliculas;
       public         heap    postgres    false            �            1259    40846    peliculas_actores    TABLE     �   CREATE TABLE public.peliculas_actores (
    id_pelicula integer NOT NULL,
    id_actor integer NOT NULL,
    id_personaje integer
);
 %   DROP TABLE public.peliculas_actores;
       public         heap    postgres    false            �            1259    40812    peliculas_directores    TABLE     q   CREATE TABLE public.peliculas_directores (
    id_pelicula integer NOT NULL,
    id_director integer NOT NULL
);
 (   DROP TABLE public.peliculas_directores;
       public         heap    postgres    false            �            1259    40796    peliculas_id_pelicula_seq    SEQUENCE     �   CREATE SEQUENCE public.peliculas_id_pelicula_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.peliculas_id_pelicula_seq;
       public          postgres    false    215            �           0    0    peliculas_id_pelicula_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.peliculas_id_pelicula_seq OWNED BY public.peliculas.id_pelicula;
          public          postgres    false    214            �            1259    40835 
   personajes    TABLE     �   CREATE TABLE public.personajes (
    id_personaje integer NOT NULL,
    nombre_personaje character varying(100),
    id_actor integer
);
    DROP TABLE public.personajes;
       public         heap    postgres    false            �            1259    40834    personajes_id_personaje_seq    SEQUENCE     �   CREATE SEQUENCE public.personajes_id_personaje_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.personajes_id_personaje_seq;
       public          postgres    false    222            �           0    0    personajes_id_personaje_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.personajes_id_personaje_seq OWNED BY public.personajes.id_personaje;
          public          postgres    false    221            �            1259    40903    promociones    TABLE     t   CREATE TABLE public.promociones (
    id_promocion integer NOT NULL,
    descripcion text,
    descuento numeric
);
    DROP TABLE public.promociones;
       public         heap    postgres    false            �            1259    40902    promociones_id_promocion_seq    SEQUENCE     �   CREATE SEQUENCE public.promociones_id_promocion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.promociones_id_promocion_seq;
       public          postgres    false    231            �           0    0    promociones_id_promocion_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.promociones_id_promocion_seq OWNED BY public.promociones.id_promocion;
          public          postgres    false    230            �            1259    40874    salas    TABLE     �   CREATE TABLE public.salas (
    id_sala integer NOT NULL,
    nombre character varying(100),
    numero integer,
    cantidad_butacas integer,
    id_cine integer
);
    DROP TABLE public.salas;
       public         heap    postgres    false            �            1259    40873    salas_id_sala_seq    SEQUENCE     �   CREATE SEQUENCE public.salas_id_sala_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.salas_id_sala_seq;
       public          postgres    false    227            �           0    0    salas_id_sala_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.salas_id_sala_seq OWNED BY public.salas.id_sala;
          public          postgres    false    226            �           2604    40831    actores id_actor    DEFAULT     t   ALTER TABLE ONLY public.actores ALTER COLUMN id_actor SET DEFAULT nextval('public.actores_id_actor_seq'::regclass);
 ?   ALTER TABLE public.actores ALTER COLUMN id_actor DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    40870    cines id_cine    DEFAULT     n   ALTER TABLE ONLY public.cines ALTER COLUMN id_cine SET DEFAULT nextval('public.cines_id_cine_seq'::regclass);
 <   ALTER TABLE public.cines ALTER COLUMN id_cine DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    40809    directores id_director    DEFAULT     �   ALTER TABLE ONLY public.directores ALTER COLUMN id_director SET DEFAULT nextval('public.directores_id_director_seq'::regclass);
 E   ALTER TABLE public.directores ALTER COLUMN id_director DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    40889    funciones id_funcion    DEFAULT     |   ALTER TABLE ONLY public.funciones ALTER COLUMN id_funcion SET DEFAULT nextval('public.funciones_id_funcion_seq'::regclass);
 C   ALTER TABLE public.funciones ALTER COLUMN id_funcion DROP DEFAULT;
       public          postgres    false    228    229    229            �           2604    40930    opiniones id_opinion    DEFAULT     |   ALTER TABLE ONLY public.opiniones ALTER COLUMN id_opinion SET DEFAULT nextval('public.opiniones_id_opinion_seq'::regclass);
 C   ALTER TABLE public.opiniones ALTER COLUMN id_opinion DROP DEFAULT;
       public          postgres    false    234    233    234            �           2604    40800    peliculas id_pelicula    DEFAULT     ~   ALTER TABLE ONLY public.peliculas ALTER COLUMN id_pelicula SET DEFAULT nextval('public.peliculas_id_pelicula_seq'::regclass);
 D   ALTER TABLE public.peliculas ALTER COLUMN id_pelicula DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    40838    personajes id_personaje    DEFAULT     �   ALTER TABLE ONLY public.personajes ALTER COLUMN id_personaje SET DEFAULT nextval('public.personajes_id_personaje_seq'::regclass);
 F   ALTER TABLE public.personajes ALTER COLUMN id_personaje DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    40906    promociones id_promocion    DEFAULT     �   ALTER TABLE ONLY public.promociones ALTER COLUMN id_promocion SET DEFAULT nextval('public.promociones_id_promocion_seq'::regclass);
 G   ALTER TABLE public.promociones ALTER COLUMN id_promocion DROP DEFAULT;
       public          postgres    false    231    230    231            �           2604    40877    salas id_sala    DEFAULT     n   ALTER TABLE ONLY public.salas ALTER COLUMN id_sala SET DEFAULT nextval('public.salas_id_sala_seq'::regclass);
 <   ALTER TABLE public.salas ALTER COLUMN id_sala DROP DEFAULT;
       public          postgres    false    227    226    227            �          0    40828    actores 
   TABLE DATA           A   COPY public.actores (id_actor, nombre, nacionalidad) FROM stdin;
    public          postgres    false    220   jl       �          0    40867    cines 
   TABLE DATA           E   COPY public.cines (id_cine, nombre, direccion, telefono) FROM stdin;
    public          postgres    false    225   �l       �          0    40806 
   directores 
   TABLE DATA           G   COPY public.directores (id_director, nombre, nacionalidad) FROM stdin;
    public          postgres    false    217   �m       �          0    40886 	   funciones 
   TABLE DATA           `   COPY public.funciones (id_funcion, dia_semana, hora_comienzo, id_sala, id_pelicula) FROM stdin;
    public          postgres    false    229   �m       �          0    40911    funciones_promociones 
   TABLE DATA           I   COPY public.funciones_promociones (id_funcion, id_promocion) FROM stdin;
    public          postgres    false    232   >n       �          0    40927 	   opiniones 
   TABLE DATA           |   COPY public.opiniones (id_opinion, id_pelicula, nombre_persona, edad, fecha_registro, calificacion, comentario) FROM stdin;
    public          postgres    false    234   gn       �          0    40797 	   peliculas 
   TABLE DATA           �   COPY public.peliculas (id_pelicula, titulo_distribucion, titulo_original, genero, idioma_original, subtitulos_espanol, paises_origen, ano_produccion, url_sitio_web, duracion, calificacion, fecha_estreno_santiago, resumen) FROM stdin;
    public          postgres    false    215   (o       �          0    40846    peliculas_actores 
   TABLE DATA           P   COPY public.peliculas_actores (id_pelicula, id_actor, id_personaje) FROM stdin;
    public          postgres    false    223   �p       �          0    40812    peliculas_directores 
   TABLE DATA           H   COPY public.peliculas_directores (id_pelicula, id_director) FROM stdin;
    public          postgres    false    218   �p       �          0    40835 
   personajes 
   TABLE DATA           N   COPY public.personajes (id_personaje, nombre_personaje, id_actor) FROM stdin;
    public          postgres    false    222   q       �          0    40903    promociones 
   TABLE DATA           K   COPY public.promociones (id_promocion, descripcion, descuento) FROM stdin;
    public          postgres    false    231   Nq       �          0    40874    salas 
   TABLE DATA           S   COPY public.salas (id_sala, nombre, numero, cantidad_butacas, id_cine) FROM stdin;
    public          postgres    false    227   �q       �           0    0    actores_id_actor_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.actores_id_actor_seq', 6, true);
          public          postgres    false    219            �           0    0    cines_id_cine_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.cines_id_cine_seq', 3, true);
          public          postgres    false    224            �           0    0    directores_id_director_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.directores_id_director_seq', 3, true);
          public          postgres    false    216            �           0    0    funciones_id_funcion_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.funciones_id_funcion_seq', 3, true);
          public          postgres    false    228            �           0    0    opiniones_id_opinion_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.opiniones_id_opinion_seq', 3, true);
          public          postgres    false    233            �           0    0    peliculas_id_pelicula_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.peliculas_id_pelicula_seq', 3, true);
          public          postgres    false    214            �           0    0    personajes_id_personaje_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.personajes_id_personaje_seq', 3, true);
          public          postgres    false    221            �           0    0    promociones_id_promocion_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.promociones_id_promocion_seq', 3, true);
          public          postgres    false    230            �           0    0    salas_id_sala_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.salas_id_sala_seq', 3, true);
          public          postgres    false    226            �           2606    40833    actores actores_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.actores
    ADD CONSTRAINT actores_pkey PRIMARY KEY (id_actor);
 >   ALTER TABLE ONLY public.actores DROP CONSTRAINT actores_pkey;
       public            postgres    false    220                       2606    40872    cines cines_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.cines
    ADD CONSTRAINT cines_pkey PRIMARY KEY (id_cine);
 :   ALTER TABLE ONLY public.cines DROP CONSTRAINT cines_pkey;
       public            postgres    false    225            �           2606    40811    directores directores_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.directores
    ADD CONSTRAINT directores_pkey PRIMARY KEY (id_director);
 D   ALTER TABLE ONLY public.directores DROP CONSTRAINT directores_pkey;
       public            postgres    false    217                       2606    40891    funciones funciones_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.funciones
    ADD CONSTRAINT funciones_pkey PRIMARY KEY (id_funcion);
 B   ALTER TABLE ONLY public.funciones DROP CONSTRAINT funciones_pkey;
       public            postgres    false    229            
           2606    40915 0   funciones_promociones funciones_promociones_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.funciones_promociones
    ADD CONSTRAINT funciones_promociones_pkey PRIMARY KEY (id_funcion, id_promocion);
 Z   ALTER TABLE ONLY public.funciones_promociones DROP CONSTRAINT funciones_promociones_pkey;
       public            postgres    false    232    232                       2606    40934    opiniones opiniones_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.opiniones
    ADD CONSTRAINT opiniones_pkey PRIMARY KEY (id_opinion);
 B   ALTER TABLE ONLY public.opiniones DROP CONSTRAINT opiniones_pkey;
       public            postgres    false    234                        2606    40850 (   peliculas_actores peliculas_actores_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY public.peliculas_actores
    ADD CONSTRAINT peliculas_actores_pkey PRIMARY KEY (id_pelicula, id_actor);
 R   ALTER TABLE ONLY public.peliculas_actores DROP CONSTRAINT peliculas_actores_pkey;
       public            postgres    false    223    223            �           2606    40816 .   peliculas_directores peliculas_directores_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.peliculas_directores
    ADD CONSTRAINT peliculas_directores_pkey PRIMARY KEY (id_pelicula, id_director);
 X   ALTER TABLE ONLY public.peliculas_directores DROP CONSTRAINT peliculas_directores_pkey;
       public            postgres    false    218    218            �           2606    40804    peliculas peliculas_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT peliculas_pkey PRIMARY KEY (id_pelicula);
 B   ALTER TABLE ONLY public.peliculas DROP CONSTRAINT peliculas_pkey;
       public            postgres    false    215            �           2606    40840    personajes personajes_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.personajes
    ADD CONSTRAINT personajes_pkey PRIMARY KEY (id_personaje);
 D   ALTER TABLE ONLY public.personajes DROP CONSTRAINT personajes_pkey;
       public            postgres    false    222                       2606    40910    promociones promociones_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.promociones
    ADD CONSTRAINT promociones_pkey PRIMARY KEY (id_promocion);
 F   ALTER TABLE ONLY public.promociones DROP CONSTRAINT promociones_pkey;
       public            postgres    false    231                       2606    40879    salas salas_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.salas
    ADD CONSTRAINT salas_pkey PRIMARY KEY (id_sala);
 :   ALTER TABLE ONLY public.salas DROP CONSTRAINT salas_pkey;
       public            postgres    false    227                       2606    40897 $   funciones funciones_id_pelicula_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.funciones
    ADD CONSTRAINT funciones_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES public.peliculas(id_pelicula);
 N   ALTER TABLE ONLY public.funciones DROP CONSTRAINT funciones_id_pelicula_fkey;
       public          postgres    false    215    229    3318                       2606    40892     funciones funciones_id_sala_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.funciones
    ADD CONSTRAINT funciones_id_sala_fkey FOREIGN KEY (id_sala) REFERENCES public.salas(id_sala);
 J   ALTER TABLE ONLY public.funciones DROP CONSTRAINT funciones_id_sala_fkey;
       public          postgres    false    229    3332    227                       2606    40916 ;   funciones_promociones funciones_promociones_id_funcion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.funciones_promociones
    ADD CONSTRAINT funciones_promociones_id_funcion_fkey FOREIGN KEY (id_funcion) REFERENCES public.funciones(id_funcion);
 e   ALTER TABLE ONLY public.funciones_promociones DROP CONSTRAINT funciones_promociones_id_funcion_fkey;
       public          postgres    false    229    3334    232                       2606    40921 =   funciones_promociones funciones_promociones_id_promocion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.funciones_promociones
    ADD CONSTRAINT funciones_promociones_id_promocion_fkey FOREIGN KEY (id_promocion) REFERENCES public.promociones(id_promocion);
 g   ALTER TABLE ONLY public.funciones_promociones DROP CONSTRAINT funciones_promociones_id_promocion_fkey;
       public          postgres    false    3336    232    231                       2606    40935 $   opiniones opiniones_id_pelicula_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.opiniones
    ADD CONSTRAINT opiniones_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES public.peliculas(id_pelicula);
 N   ALTER TABLE ONLY public.opiniones DROP CONSTRAINT opiniones_id_pelicula_fkey;
       public          postgres    false    3318    215    234                       2606    40856 1   peliculas_actores peliculas_actores_id_actor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.peliculas_actores
    ADD CONSTRAINT peliculas_actores_id_actor_fkey FOREIGN KEY (id_actor) REFERENCES public.actores(id_actor);
 [   ALTER TABLE ONLY public.peliculas_actores DROP CONSTRAINT peliculas_actores_id_actor_fkey;
       public          postgres    false    3324    223    220                       2606    40851 4   peliculas_actores peliculas_actores_id_pelicula_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.peliculas_actores
    ADD CONSTRAINT peliculas_actores_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES public.peliculas(id_pelicula);
 ^   ALTER TABLE ONLY public.peliculas_actores DROP CONSTRAINT peliculas_actores_id_pelicula_fkey;
       public          postgres    false    3318    223    215                       2606    40861 5   peliculas_actores peliculas_actores_id_personaje_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.peliculas_actores
    ADD CONSTRAINT peliculas_actores_id_personaje_fkey FOREIGN KEY (id_personaje) REFERENCES public.personajes(id_personaje);
 _   ALTER TABLE ONLY public.peliculas_actores DROP CONSTRAINT peliculas_actores_id_personaje_fkey;
       public          postgres    false    223    3326    222                       2606    40822 :   peliculas_directores peliculas_directores_id_director_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.peliculas_directores
    ADD CONSTRAINT peliculas_directores_id_director_fkey FOREIGN KEY (id_director) REFERENCES public.directores(id_director);
 d   ALTER TABLE ONLY public.peliculas_directores DROP CONSTRAINT peliculas_directores_id_director_fkey;
       public          postgres    false    218    3320    217                       2606    40817 :   peliculas_directores peliculas_directores_id_pelicula_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.peliculas_directores
    ADD CONSTRAINT peliculas_directores_id_pelicula_fkey FOREIGN KEY (id_pelicula) REFERENCES public.peliculas(id_pelicula);
 d   ALTER TABLE ONLY public.peliculas_directores DROP CONSTRAINT peliculas_directores_id_pelicula_fkey;
       public          postgres    false    3318    218    215                       2606    40841 #   personajes personajes_id_actor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.personajes
    ADD CONSTRAINT personajes_id_actor_fkey FOREIGN KEY (id_actor) REFERENCES public.actores(id_actor);
 M   ALTER TABLE ONLY public.personajes DROP CONSTRAINT personajes_id_actor_fkey;
       public          postgres    false    3324    220    222                       2606    40880    salas salas_id_cine_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.salas
    ADD CONSTRAINT salas_id_cine_fkey FOREIGN KEY (id_cine) REFERENCES public.cines(id_cine);
 B   ALTER TABLE ONLY public.salas DROP CONSTRAINT salas_id_cine_fkey;
       public          postgres    false    227    225    3330            �   `   x�3��M,)�H-Wp*�OI-�L��t-.IL�/��LI�+N�2*)����H�K�G�6��NM�+UJM-K-�tN�KL�˘6���f8͎���� �IA       �   �   x��M�0@���s  :�K�&.uc⦡�4bk��+��\Lq��%�Cn�~����M��ڱ6��"�0�07��
��b~�L퀈|łE�9�-�N��3,��x<,�Ϯ�-�JRC��V%.û�A�̵��{g���^�~B"f��1���,�      �   U   x�3��OO-Rp��I-*�t-.IL�/��LI�+N�2�t+J�K�,Vp�/JQp�/(��IDWe�铘������_^���.���� �x#�      �   E   x�3��)�K-�44�20 "NCNC.#N�Ģ����1XԈӈ˘�7��ʢ�����T�1�1W� �5�      �      x�3�4�2�4�2�4����� A      �   �   x�e�=
�@�z�s���n��RA��f�"$���zK�T9�^�%M����H���`�?�_�%(��H�HmQ���;6#����'�~ ��c�j��Y?��J�j�P�{b1sWC����������a84�\��~����Z/؅�a�¡��R(���w�!��&H      �   ~  x����n�0���S='���c�-h��X
�zۅ�際Ly�H{���}�IN;���'��H����J�W�Ú�������|f�W+�N7r���8���ѕ��w��8��ʺ>Q���[�v�����&#ycU���Ӳ(�m��&���1/��Չ��a�$��hiC@�Y�\��Y�Q��TC�C �)%�񈭥<�֗��	�ڴ�����<���������\���1�Wo����^�<=}�w^͋E�[#�켱�Ib�Ѵd�C�p`}�'�b��R�<[�[��&����4�U����V͇�V�y��RׯX�i�Hy�Χ:�,��S��O��������-�[p�9��L��!9��+ly���gY��q�[      �      x�3�4�4�2�4���2�4Q1z\\\ /,�      �      x�3�4�2�4�2�4����� A      �   1   x�3���MJ�4�2��,�Wp�/�I��K�4�2��K��4����� �
0      �   Y   x�3�tI-N.M�+�WHIUH-.)J���4�3�2�4�0TH����Ĕ�b���b���Բ�b�S.c$��E� ݥ)��y%`�\1z\\\ ��      �   5   x�3�N�IT0�BNC.#��������1D��Ә�Ә+F��� +N	�     