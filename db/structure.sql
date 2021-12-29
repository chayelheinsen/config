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

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: configurations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.configurations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    content jsonb DEFAULT '"{}"'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: environments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.environments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name public.citext NOT NULL,
    configuration_id uuid NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: configurations configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.configurations
    ADD CONSTRAINT configurations_pkey PRIMARY KEY (id);


--
-- Name: environments environments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.environments
    ADD CONSTRAINT environments_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_configurations_on_content; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_configurations_on_content ON public.configurations USING gin (content);


--
-- Name: index_environments_on_configuration_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_environments_on_configuration_id ON public.environments USING btree (configuration_id);


--
-- Name: environments fk_rails_af2a4cb996; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.environments
    ADD CONSTRAINT fk_rails_af2a4cb996 FOREIGN KEY (configuration_id) REFERENCES public.configurations(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20211228142430'),
('20211228142952'),
('20211229153425');


