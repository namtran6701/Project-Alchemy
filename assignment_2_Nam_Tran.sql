drop schema if EXISTS assignment_2;
create schema assignment_2;
use assignment_2;

# RES01: QUERY
SELECT 
    airline,
    COUNT(*) flight_count,
    AVG(arr_delay) AS avg_arr_delay
FROM
    flights
GROUP BY airline
ORDER BY avg_arr_delay DESC
LIMIT 10;

# RES01: RESULT 

# RES02: QUERY 
SELECT 
    DATE_FORMAT(fl_date, '%M') AS month_name,
    airline,
    COUNT(*) AS flight_count,
    AVG(arr_delay) AS avg_arr_delay
FROM
    flights
GROUP BY month_name , airline
ORDER BY month_name ASC , avg_arr_delay DESC;

# RES02: RESULT

# RES03: QUERY 
SELECT 
airline,
avg(case when date_format(fl_date, '%M') = 'january' then arr_delay else 0 end) as january_mean_arr_delay,
avg(case when date_format(fl_date, '%M') = 'may' then arr_delay else 0 end) as may_mean_arr_delay,
(avg(case when date_format(fl_date, '%M') = 'may' then arr_delay else 0 end) - avg(case when date_format(fl_date, '%M') = 'january' then arr_delay else 0 end)) as january_vs_may_change
from flights
group by airline 
order by 4;

# RES03: RESULT


# RES04: QUERY 
SELECT 
date_format(fl_date, '%W') as day_of_week,
avg(dep_delay) as avg_dep_delay,
avg(arr_delay) as avg_arr_delay,
count(*) as flight_count
from flights
group by day_of_week
order by 2 desc, 3 desc;

#RES04: RESULT

# RES05: QUERY 

SELECT 
case 
	when date_format(fl_date, '%w') in (0, 6) 
    then 'Weekend' 
    else 'Weekday' 
    end as week_day_indicator,
avg(dep_delay) as avg_dep_delay,
avg(arr_delay) as avg_arr_delay,
count(*) as flight_count
from flights
group by week_day_indicator;

# RES05: RESULT

# RES06: QUERY 

select 
airline,
avg(distance) as mean_distance,
max(distance) as max_distance, 
min(distance) as min_distance
from flights 
group by airline
order by mean_distance asc;

# RES06: RESULT

# RES07: QUERY 
select 
airline,
avg(air_time) as mean_time,
max(air_time) as max_time, 
min(air_time) as min_time
from flights 
group by airline
order by mean_time asc;

# RES07: RESULT

# RES08: QUERY 
SELECT
airline,
origin_state_nm, 
count(*) as flight_count,
avg(dep_delay) as avg_dep_delay
from flights 
where origin_state_nm = 'Florida'
group by 1,2
order by avg_dep_delay asc;
# RES08

# RES09: QUERY 

select 
origin_city_name,
dest_city_name,
air_time as max_airtime, 
air_time/60 as max_airtime_hrs 
from flights 
order by max_airtime desc
limit 5;

# RES09: RESULT

# RES10: QUERY 
select 
origin_city_name,
dest_city_name,
avg(air_time) mean_airtime,
avg(air_time)/60 as mean_airtime_hrs,
count(*) as flight_count
from flights 
group by 1, 2
having avg(arr_delay) >15 and flight_count >10
order by mean_airtime desc
limit 5;

# RES10: RESULT

# RES11: QUERY

select 
origin_city_name,
dest_city_name, 
avg(arr_delay) as mean_arr_delay,
count(*) as flight_count
from flights 
group by 1,2  
having (mean_arr_delay <-10) and (flight_count > 20) 
order by mean_arr_delay asc
limit 5;

# RES11: RESULT

# RES12: QUERY 

select 
origin_city_name,
dest_city_name, 
avg(arr_delay) as mean_arr_delay,
count(*) as flight_count
from flights 
where weather_delay >0
group by 1,2  
having (mean_arr_delay >15) and (flight_count > 2) 
order by mean_arr_delay asc;

# RES12: RESULT

# RES13: QUERY

select 
airline, 
origin_state_nm,
avg(dep_delay) as mean_dep_delay
from flights
where origin_state_nm = 'New York'
group by 1, 2
having mean_dep_delay > (select avg(dep_delay) from flights where origin_state_nm <> 'New York')
order by mean_dep_delay desc;

# RES13: RESULT

# RES14 : QUERY 

select 
airline, 
count(*) as total_flight,
sum(case when ((dep_delay>0) or (arr_delay>0)) then 1 else 0 end) as total_delay,
(sum(case when ((dep_delay>0) or (arr_delay>0)) then 1 else 0 end)/count(*))*100 as delay_percentage
from flights 
where date_format(fl_date, '%Y') = 2023
group by airline
order by delay_percentage desc;

# RES14: RESULT

# RES15: QUERY 

select 
airline, 
avg(distance/(air_time/60)) as `speed(mph)`,
avg(distance) as mean_flight_distance
from flights 
group by airline
having `speed(mph)` > (select avg(distance/(air_time/60)) from flights)
order by `speed(mph)` desc;

# RES15: RESULT
