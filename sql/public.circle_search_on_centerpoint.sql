-- FUNCTION: public.circle_search_on_centerpoint(numeric, numeric, integer)

-- DROP FUNCTION IF EXISTS public.circle_search_on_centerpoint(numeric, numeric, integer);

CREATE OR REPLACE FUNCTION public.circle_search_on_centerpoint(
	center_latitude numeric,
	center_longitude numeric,
	radius integer)
    RETURNS TABLE(ctr_latitude numeric, ctr_longitude numeric, ctr_geocord geography, distance double precision, ip_range_start character varying, ip_range_end character varying, country_code character, state1 character varying, state2 character varying, city character varying, postcode character varying, latitude numeric, longitude numeric, timezone character varying, geocord geography) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 50000

AS $BODY$
    SELECT 
	center_latitude, 
	center_longitude, 
	concat('SRID=4326;POINT(', center_longitude, ' ', center_latitude, ')')::geography,
	ST_Distance( concat('SRID=4326;POINT(', center_longitude, ' ', center_latitude, ')')::geography, h.geocord),
	h.ip_range_start, 
	h.ip_range_end, 
	h.country_code, 
	h.state1, 
	h.state2, 
	h.city, h.postcode, 
	h.latitude, 
	h.longitude, 
	h.timezone, 
	h.geocord
	FROM public."dbip-city-ipv4" h 
	WHERE  ST_DWithin(concat('SRID=4326;POINT(', center_longitude, ' ', center_latitude, ')')::geography, h.geocord, radius)
	ORDER BY ST_Distance(concat('SRID=4326;POINT(', center_longitude, ' ', center_latitude, ')')::geography, h.geocord) ;
$BODY$;

ALTER FUNCTION public.circle_search_on_centerpoint(numeric, numeric, integer)
    OWNER TO postgresql_master;

GRANT EXECUTE ON FUNCTION public.circle_search_on_centerpoint(numeric, numeric, integer) TO PUBLIC;

GRANT EXECUTE ON FUNCTION public.circle_search_on_centerpoint(numeric, numeric, integer) TO featureserver;

GRANT EXECUTE ON FUNCTION public.circle_search_on_centerpoint(numeric, numeric, integer) TO postgresql_master;

