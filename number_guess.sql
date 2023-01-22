--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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
    username character varying(22),
    number_of_guesses integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    username character varying(22) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES ('Pacome', 9);
INSERT INTO public.games VALUES ('user_1674387216628', 454);
INSERT INTO public.games VALUES ('user_1674387216628', 610);
INSERT INTO public.games VALUES ('user_1674387216627', 868);
INSERT INTO public.games VALUES ('user_1674387216627', 520);
INSERT INTO public.games VALUES ('user_1674387216628', 458);
INSERT INTO public.games VALUES ('user_1674387216628', 874);
INSERT INTO public.games VALUES ('user_1674387216628', 991);
INSERT INTO public.games VALUES ('user_1674387427895', 828);
INSERT INTO public.games VALUES ('user_1674387427895', 18);
INSERT INTO public.games VALUES ('user_1674387427894', 332);
INSERT INTO public.games VALUES ('user_1674387427894', 443);
INSERT INTO public.games VALUES ('user_1674387427895', 412);
INSERT INTO public.games VALUES ('user_1674387427895', 227);
INSERT INTO public.games VALUES ('user_1674387427895', 649);
INSERT INTO public.games VALUES ('user_1674387635067', 376);
INSERT INTO public.games VALUES ('user_1674387635067', 523);
INSERT INTO public.games VALUES ('user_1674387635066', 556);
INSERT INTO public.games VALUES ('user_1674387635066', 224);
INSERT INTO public.games VALUES ('user_1674387635067', 930);
INSERT INTO public.games VALUES ('user_1674387635067', 911);
INSERT INTO public.games VALUES ('user_1674387635067', 156);
INSERT INTO public.games VALUES ('user_1674388409114', 813);
INSERT INTO public.games VALUES ('user_1674388409114', 807);
INSERT INTO public.games VALUES ('user_1674388409113', 406);
INSERT INTO public.games VALUES ('user_1674388409113', 487);
INSERT INTO public.games VALUES ('user_1674388409114', 281);
INSERT INTO public.games VALUES ('user_1674388409114', 263);
INSERT INTO public.games VALUES ('user_1674388409114', 160);
INSERT INTO public.games VALUES ('user_1674388425599', 898);
INSERT INTO public.games VALUES ('user_1674388425599', 352);
INSERT INTO public.games VALUES ('user_1674388425598', 169);
INSERT INTO public.games VALUES ('user_1674388425598', 767);
INSERT INTO public.games VALUES ('user_1674388425599', 973);
INSERT INTO public.games VALUES ('user_1674388425599', 298);
INSERT INTO public.games VALUES ('user_1674388425599', 350);
INSERT INTO public.games VALUES ('user_1674388887355', 822);
INSERT INTO public.games VALUES ('user_1674388887355', 935);
INSERT INTO public.games VALUES ('user_1674388887354', 262);
INSERT INTO public.games VALUES ('user_1674388887354', 869);
INSERT INTO public.games VALUES ('user_1674388887355', 513);
INSERT INTO public.games VALUES ('user_1674388887355', 289);
INSERT INTO public.games VALUES ('user_1674388887355', 879);
INSERT INTO public.games VALUES ('user_1674389091850', 443);
INSERT INTO public.games VALUES ('user_1674389091850', 522);
INSERT INTO public.games VALUES ('user_1674389091849', 688);
INSERT INTO public.games VALUES ('user_1674389091849', 426);
INSERT INTO public.games VALUES ('user_1674389091850', 342);
INSERT INTO public.games VALUES ('user_1674389091850', 344);
INSERT INTO public.games VALUES ('user_1674389091850', 29);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES ('Pacome');
INSERT INTO public.users VALUES ('user_1674387216628');
INSERT INTO public.users VALUES ('user_1674387216627');
INSERT INTO public.users VALUES ('user_1674387427895');
INSERT INTO public.users VALUES ('user_1674387427894');
INSERT INTO public.users VALUES ('user_1674387635067');
INSERT INTO public.users VALUES ('user_1674387635066');
INSERT INTO public.users VALUES ('user_1674388409114');
INSERT INTO public.users VALUES ('user_1674388409113');
INSERT INTO public.users VALUES ('user_1674388425599');
INSERT INTO public.users VALUES ('user_1674388425598');
INSERT INTO public.users VALUES ('user_1674388887355');
INSERT INTO public.users VALUES ('user_1674388887354');
INSERT INTO public.users VALUES ('user_1674389091850');
INSERT INTO public.users VALUES ('user_1674389091849');


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- Name: games games_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_username_fkey FOREIGN KEY (username) REFERENCES public.users(username);


--
-- PostgreSQL database dump complete
--

