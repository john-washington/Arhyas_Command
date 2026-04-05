-- Table: public.circle_search_result

-- DROP TABLE IF EXISTS public.circle_search_result;

CREATE TABLE IF NOT EXISTS public.circle_search_result_language_coded
(
    system_id integer NOT NULL DEFAULT nextval('circle_search_result_language_coded_system_id_seq'::regclass),
  	result jsonb,
    mod_datetime timestamp with time zone,
    CONSTRAINT circle_search_result_language_coded_pkey PRIMARY KEY (system_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.circle_search_result_language_coded
    OWNER to postgresql_master;

REVOKE ALL ON TABLE public.circle_search_result_language_coded FROM featureserver;

GRANT INSERT, UPDATE ON TABLE public.circle_search_result_language_coded TO featureserver;

GRANT ALL ON TABLE public.circle_search_result_language_coded TO postgresql_master;