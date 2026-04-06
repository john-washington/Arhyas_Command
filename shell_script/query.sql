--select * from arhyas_command_tracking_tmp where track ->> 'countryCode' = 'GB'

--select distinct mod_datetime from circle_search_result;
--where result ->> 'state1' = 'Mississippi';

select result ->> 'network' as network, 
result ->> 'distance' as distance,
result ->> 'ctr_latitude' as ctr_latitude,
result ->> 'ctr_longitude' as ctr_longitude,
result ->> 'h_latitude' as latitude,
result ->> 'h_longitude' as longitude,
result ->> 'city_name' as city,
result ->> 'time_zone' as timezone
from circle_search_result_language_coded
where mod_datetime = '2026-04-05 11:43:49.603201+08'
;