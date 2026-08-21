-- FUNCTION: public.get_circle_search_result_by_timestamp_en(numeric, numeric, character varying)

-- DROP FUNCTION IF EXISTS public.get_circle_search_result_by_timestamp_en(numeric, numeric, character varying);

CREATE OR REPLACE FUNCTION public.get_circle_search_result_by_timestamp_en(
	center_latitude numeric,
	center_longitude numeric,
	query_timestring character varying)
    RETURNS TABLE(network character varying, distance double precision, ctr_latitude numeric, ctr_longitude numeric, h_latitude numeric, h_longitude numeric, country_name character varying, city_name character varying, time_zone character varying) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 50000

AS $BODY$
select result ->> 'network' as network, 
(result ->> 'distance')::numeric as distance,
(result ->> 'ctr_latitude')::numeric as ctr_latitude,
(result ->> 'ctr_longitude')::numeric as ctr_longitude,
(result ->> 'h_latitude')::numeric as latitude,
(result ->> 'h_longitude')::numeric as longitude,
result ->> 'country_name' as country_name,
result ->> 'city_name' as city,
result ->> 'time_zone' as timezone
from circle_search_result_language_coded
where mod_datetime = TO_TIMESTAMP(query_timestring, 'YYYYMMDD HH24:MI:SI')
;
$BODY$;

ALTER FUNCTION public.get_circle_search_result_by_timestamp_en(numeric, numeric, character varying)
    OWNER TO postgresql_master;

GRANT EXECUTE ON FUNCTION public.get_circle_search_result_by_timestamp_en(numeric, numeric, character varying) TO PUBLIC;

GRANT EXECUTE ON FUNCTION public.get_circle_search_result_by_timestamp_en(numeric, numeric, character varying) TO featureserver;

GRANT EXECUTE ON FUNCTION public.get_circle_search_result_by_timestamp_en(numeric, numeric, character varying) TO postgresql_master;

