-- FUNCTION: public.circle_search_on_centerpoint_zh_cn(numeric, numeric, integer)

-- DROP FUNCTION IF EXISTS public.circle_search_on_centerpoint_zh_cn(numeric, numeric, integer);

CREATE OR REPLACE FUNCTION public.circle_search_on_centerpoint_zh_cn(
	center_latitude numeric,
	center_longitude numeric,
	radius integer)
    RETURNS TABLE(distance double precision, ctr_latitude numeric, ctr_longitude numeric, ctr_geocord geography, network character varying, h_geoname_id integer, country_geoname_id integer, h_represented_country_geoname_id integer, is_anonymous_proxy bit, h_is_satellite_provider bit, postcode character varying, h_latitude numeric, h_longitude numeric, accuracy_radius integer, is_anycast bit, h_geocord geography, locale_code character varying, continent_code character, continent_name character varying, country_iso_code character, country_name character varying, subdivision_1_iso_code character, subdivision_1_name character varying, subdivision_2_iso_code character, subdivision_2_name character varying, city_name character varying, metro_code character varying, time_zone character varying, is_in_european_union bit) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 10000

AS $BODY$
    SELECT 
ST_Distance(concat('SRID=4326;POINT(', center_longitude, ' ', center_latitude, ')')::geography, h.geocord) AS distance,
	center_latitude, 
	center_longitude, 
	concat('SRID=4326;POINT(', center_longitude, ' ', center_latitude, ')')::geography,
	h.network,
	h.geoname_id, 
	h.country_geoname_id, 
	h.represented_country_geoname_id,
	h.is_anonymous_proxy,
	h.is_satellite_provider,
	h.postcode,
    h.latitude, 
	h.longitude, 
	h.accuracy_radius,
	h.is_anycast,
	h.geocord,
h.locale_code, 
h.continent_code, 
h.continent_name, 
h.country_iso_code, 
h.country_name, 
h.subdivision_1_iso_code, 
h.subdivision_1_name, 
h.subdivision_2_iso_code, 
h.subdivision_2_name, 
h.city_name, 
h.metro_code, 
h.time_zone, 
h.is_in_european_union
	FROM public."geolite2-city-ipv4-locations-view-zh-CN" h 
		--ON (ST_Distance(s.geocord, h.geocord) < $2)
	WHERE ST_DWithin(concat('SRID=4326;POINT(', center_longitude, ' ', center_latitude, ')')::geography, h.geocord, radius)
	ORDER BY ST_Distance(concat('SRID=4326;POINT(', center_longitude, ' ', center_latitude, ')')::geography, h.geocord);
$BODY$;

ALTER FUNCTION public.circle_search_on_centerpoint_zh_cn(numeric, numeric, integer)
    OWNER TO postgresql_master;

GRANT EXECUTE ON FUNCTION public.circle_search_on_centerpoint_zh_cn(numeric, numeric, integer) TO PUBLIC;

GRANT EXECUTE ON FUNCTION public.circle_search_on_centerpoint_zh_cn(numeric, numeric, integer) TO featureserver;

GRANT EXECUTE ON FUNCTION public.circle_search_on_centerpoint_zh_cn(numeric, numeric, integer) TO postgresql_master;

