--select count(*) from geolite2-city-ipv4

--SELECT system_id, mod_time, ip_range_start, ip_range_end, country_code, state1, state2, city, postcode, latitude, longitude, timezone, geocord

--select count(*) 
--FROM public."dbip-city-ipv4-tmp"; 

--6127503
--9212553

--select count(*) 
--FROM public."dbip-city-ipv4" --5676841

/*
CREATE INDEX "idx_dbip-city-ipv4-latlon"
    ON public."dbip-city-ipv4"(latitude, longitude)
    WITH (deduplicate_items=True)
    TABLESPACE pg_default;
*/

/*
CREATE INDEX "idx_dbip-city-ipv4-tmp-latlon"
    ON public."dbip-city-ipv4-tmp"(latitude, longitude)
    WITH (deduplicate_items=True)
    TABLESPACE pg_default;
	*/
	


--select count(*) --615397

INSERT INTO public."dbip-city-ipv4"(
mod_time,
ip_range_start, 
ip_range_end, 
country_code, state1, state2, city, postcode, latitude, 
longitude, timezone, geocord )
SELECT 
NOW(), 
t1.ip_range_start, 
t1.ip_range_end,
t1.country_code, 
t1.state1, 
t1.state2, 
t1.city, 
t1.postcode, 
t1.latitude, 
t1.longitude, 
t1.timezone, 
concat('SRID=4326;POINT(', t1.longitude, ' ', t1.latitude, ')')::geography 
from public."dbip-city-ipv4-tmp" t1
left outer join public."dbip-city-ipv4" t2
on t1.latitude = t2.latitude AND t1.longitude = t2.longitude
where t2.system_id IS NULL
;




--select count(*) FROM public."geolite2-city-ipv4" --3535712

--select count(*) FROM public."geolite2-city-ipv4-tmp" -- 0