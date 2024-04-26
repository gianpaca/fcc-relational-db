--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer,
    num_of_guesses integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(25) NOT NULL,
    games_played integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (357, 125, 925);
INSERT INTO public.games VALUES (358, 125, 875);
INSERT INTO public.games VALUES (359, 126, 262);
INSERT INTO public.games VALUES (360, 126, 845);
INSERT INTO public.games VALUES (361, 125, 580);
INSERT INTO public.games VALUES (362, 125, 799);
INSERT INTO public.games VALUES (363, 125, 763);
INSERT INTO public.games VALUES (364, 127, 777);
INSERT INTO public.games VALUES (365, 127, 37);
INSERT INTO public.games VALUES (366, 128, 997);
INSERT INTO public.games VALUES (367, 128, 239);
INSERT INTO public.games VALUES (368, 127, 505);
INSERT INTO public.games VALUES (369, 127, 943);
INSERT INTO public.games VALUES (370, 127, 440);
INSERT INTO public.games VALUES (371, 129, 464);
INSERT INTO public.games VALUES (372, 129, 881);
INSERT INTO public.games VALUES (373, 130, 472);
INSERT INTO public.games VALUES (374, 130, 944);
INSERT INTO public.games VALUES (375, 129, 819);
INSERT INTO public.games VALUES (376, 129, 941);
INSERT INTO public.games VALUES (377, 129, 953);
INSERT INTO public.games VALUES (378, 131, 68);
INSERT INTO public.games VALUES (379, 131, 384);
INSERT INTO public.games VALUES (380, 132, 783);
INSERT INTO public.games VALUES (381, 132, 297);
INSERT INTO public.games VALUES (382, 131, 763);
INSERT INTO public.games VALUES (383, 131, 600);
INSERT INTO public.games VALUES (384, 131, 411);
INSERT INTO public.games VALUES (385, 133, 288);
INSERT INTO public.games VALUES (386, 133, 31);
INSERT INTO public.games VALUES (387, 134, 981);
INSERT INTO public.games VALUES (388, 134, 564);
INSERT INTO public.games VALUES (389, 133, 467);
INSERT INTO public.games VALUES (390, 133, 496);
INSERT INTO public.games VALUES (391, 133, 617);
INSERT INTO public.games VALUES (392, 135, 948);
INSERT INTO public.games VALUES (393, 135, 305);
INSERT INTO public.games VALUES (394, 136, 201);
INSERT INTO public.games VALUES (395, 136, 865);
INSERT INTO public.games VALUES (396, 135, 967);
INSERT INTO public.games VALUES (397, 135, 465);
INSERT INTO public.games VALUES (398, 135, 196);
INSERT INTO public.games VALUES (399, 137, 972);
INSERT INTO public.games VALUES (400, 137, 324);
INSERT INTO public.games VALUES (401, 138, 562);
INSERT INTO public.games VALUES (402, 138, 740);
INSERT INTO public.games VALUES (403, 137, 371);
INSERT INTO public.games VALUES (404, 137, 623);
INSERT INTO public.games VALUES (405, 137, 680);
INSERT INTO public.games VALUES (406, 139, 735);
INSERT INTO public.games VALUES (407, 139, 556);
INSERT INTO public.games VALUES (408, 140, 921);
INSERT INTO public.games VALUES (409, 140, 405);
INSERT INTO public.games VALUES (410, 139, 74);
INSERT INTO public.games VALUES (411, 139, 560);
INSERT INTO public.games VALUES (412, 139, 537);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (126, 'user_1714159542781', 2);
INSERT INTO public.users VALUES (125, 'user_1714159542782', 5);
INSERT INTO public.users VALUES (128, 'user_1714159572481', 2);
INSERT INTO public.users VALUES (127, 'user_1714159572482', 5);
INSERT INTO public.users VALUES (130, 'user_1714159575287', 2);
INSERT INTO public.users VALUES (129, 'user_1714159575288', 5);
INSERT INTO public.users VALUES (132, 'user_1714159577558', 2);
INSERT INTO public.users VALUES (131, 'user_1714159577559', 5);
INSERT INTO public.users VALUES (134, 'user_1714159579260', 2);
INSERT INTO public.users VALUES (133, 'user_1714159579261', 5);
INSERT INTO public.users VALUES (136, 'user_1714159580731', 2);
INSERT INTO public.users VALUES (135, 'user_1714159580732', 5);
INSERT INTO public.users VALUES (138, 'user_1714159582749', 2);
INSERT INTO public.users VALUES (137, 'user_1714159582750', 5);
INSERT INTO public.users VALUES (140, 'user_1714159584638', 2);
INSERT INTO public.users VALUES (139, 'user_1714159584639', 5);


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 412, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 140, true);


--
-- Name: users users_user_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_id_key UNIQUE (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

