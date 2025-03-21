--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tipo_categoria; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipo_categoria AS ENUM (
    'comida',
    'bebida',
    'otros'
);


ALTER TYPE public.tipo_categoria OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: asociacionplatocategoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asociacionplatocategoria (
    plato_id integer NOT NULL,
    categoria_id integer NOT NULL
);


ALTER TABLE public.asociacionplatocategoria OWNER TO postgres;

--
-- Name: categoriasplato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoriasplato (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    tipo public.tipo_categoria DEFAULT 'comida'::public.tipo_categoria
);


ALTER TABLE public.categoriasplato OWNER TO postgres;

--
-- Name: categoriasplato_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categoriasplato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoriasplato_id_seq OWNER TO postgres;

--
-- Name: categoriasplato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categoriasplato_id_seq OWNED BY public.categoriasplato.id;


--
-- Name: platos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.platos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    precio numeric(6,2) NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    imagen text
);


ALTER TABLE public.platos OWNER TO postgres;

--
-- Name: platos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.platos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.platos_id_seq OWNER TO postgres;

--
-- Name: platos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.platos_id_seq OWNED BY public.platos.id;


--
-- Name: categoriasplato id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriasplato ALTER COLUMN id SET DEFAULT nextval('public.categoriasplato_id_seq'::regclass);


--
-- Name: platos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platos ALTER COLUMN id SET DEFAULT nextval('public.platos_id_seq'::regclass);


--
-- Data for Name: asociacionplatocategoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asociacionplatocategoria (plato_id, categoria_id) FROM stdin;
1	3
1	1
2	2
3	6
4	3
4	5
5	4
6	8
7	10
8	11
8	9
9	7
9	1
10	9
\.


--
-- Data for Name: categoriasplato; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoriasplato (id, nombre, tipo) FROM stdin;
1	Entrantes	comida
2	Carnes	comida
3	Pescados	comida
4	Postres	comida
5	Sopas	comida
6	Ensaladas	comida
7	Vegetariano	comida
8	Bebidas Alcohólicas	bebida
9	Bebidas Sin Alcohol	bebida
10	Cafés	bebida
11	Zumos	bebida
12	Otros	otros
\.


--
-- Data for Name: platos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.platos (id, nombre, descripcion, precio, fecha_creacion, imagen) FROM stdin;
1	Paella Valenciana	Arroz con pollo, conejo y verduras, cocinado en caldo de pescado	18.50	2025-03-21 12:00:16.814996	https://sukanku10145.github.io/imagenes/paella.jpg
2	Hamburguesa BBQ	Carne 200g con bacon, cebolla caramelizada y salsa barbacoa	12.90	2025-03-21 12:00:16.814996	https://sukanku10145.github.io/imagenes/hamburguesa.jpg
3	Ensalada César	Lechuga romana, croutons, queso parmesano y salsa tradicional	8.75	2025-03-21 12:00:16.814996	https://sukanku10145.github.io/imagenes/cesar.jpg
4	Sopa de Mariscos	Mezcla de mariscos en caldo concentrado con verduras	9.95	2025-03-21 12:00:16.814996	https://sukanku10145.github.io/imagenes/sopa_mariscos.jpg
5	Tarta de Queso	Tarta estilo Nueva York con base de galleta y coulis de frutos rojos	6.50	2025-03-21 12:00:16.814996	https://sukanku10145.github.io/imagenes/tarta_queso.jpg
6	Vino Tinto Reserva	Botella de Rioja crianza 2018	24.00	2025-03-21 12:00:16.814996	https://sukanku10145.github.io/imagenes/vino_tinto.jpg
7	Café Irlandés	Café con whiskey y crema batida	5.25	2025-03-21 12:00:16.814996	https://sukanku10145.github.io/imagenes/cafe_irlandes.jpg
8	Zumo Triple Vitaminas	Mezcla de naranja, zanahoria y jengibre	4.75	2025-03-21 12:00:16.814996	https://sukanku10145.github.io/imagenes/zumo_vitaminas.jpg
9	Tempura de Verduras	Variedad de verduras rebozadas con salsa agridulce	10.50	2025-03-21 12:00:16.814996	https://sukanku10145.github.io/imagenes/tempura.jpg
10	Agua Mineral	Botella 750ml	2.00	2025-03-21 12:00:16.814996	https://sukanku10145.github.io/imagenes/agua.jpg
\.


--
-- Name: categoriasplato_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categoriasplato_id_seq', 12, true);


--
-- Name: platos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.platos_id_seq', 10, true);


--
-- Name: asociacionplatocategoria asociacionplatocategoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asociacionplatocategoria
    ADD CONSTRAINT asociacionplatocategoria_pkey PRIMARY KEY (plato_id, categoria_id);


--
-- Name: categoriasplato categoriasplato_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriasplato
    ADD CONSTRAINT categoriasplato_nombre_key UNIQUE (nombre);


--
-- Name: categoriasplato categoriasplato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriasplato
    ADD CONSTRAINT categoriasplato_pkey PRIMARY KEY (id);


--
-- Name: platos platos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platos
    ADD CONSTRAINT platos_pkey PRIMARY KEY (id);


--
-- Name: asociacionplatocategoria asociacionplatocategoria_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asociacionplatocategoria
    ADD CONSTRAINT asociacionplatocategoria_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categoriasplato(id) ON DELETE CASCADE;


--
-- Name: asociacionplatocategoria asociacionplatocategoria_plato_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asociacionplatocategoria
    ADD CONSTRAINT asociacionplatocategoria_plato_id_fkey FOREIGN KEY (plato_id) REFERENCES public.platos(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

