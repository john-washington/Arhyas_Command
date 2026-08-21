-- View: public.geolite2-city-ipv4-locations-view-es

-- DROP VIEW public."geolite2-city-ipv4-locations-view-es";

CREATE OR REPLACE VIEW public."geolite2-city-ipv4-locations-view-es"
 AS
 SELECT a.network,
    a.geoname_id,
    a.country_geoname_id,
    a.represented_country_geoname_id,
    a.is_anonymous_proxy,
    a.is_satellite_provider,
    a.postcode,
    a.latitude,
    a.longitude,
    a.accuracy_radius,
    a.is_anycast,
    a.geocord,
    b.geoname_id AS geoname_id2,
    b.locale_code,
    b.continent_code,
    b.continent_name,
    b.country_iso_code,
    b.country_name,
    b.subdivision_1_iso_code,
    b.subdivision_1_name,
    b.subdivision_2_iso_code,
    b.subdivision_2_name,
    b.city_name,
    b.metro_code,
    b.time_zone,
    b.is_in_european_union
   FROM "geolite2-city-ipv4" a
     JOIN "geolite2-city-locations" b ON a.geoname_id = b.geoname_id
  WHERE b.locale_code::text = 'es'::text
  ORDER BY a.geoname_id, b.locale_code;

ALTER TABLE public."geolite2-city-ipv4-locations-view-es"
    OWNER TO postgresql_master;

