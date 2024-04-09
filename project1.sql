use `project1`;

drop table if exists employee;
create table `employee` (
		`employee_id` int not null auto_increment,
        `employee_name` varchar(64),
        `employee_title` varchar(64),
        `employee_dept` varchar(64),
        `full_of_part_time` char(1),
        `salary_or_hourly` varchar(10),
        `typical_hours` decimal(10,2),
        `annual_salary` decimal (10,2), 
        `hourly_rate` decimal(5,2),
        primary key (`employee_id`)
	);
    

-- insert into employee table 

describe employee;

insert into employee values
	(1,'AARON, JEFFERY M', 'SERGEANT', 'POLICE', 'F', 'Salary', null, 111444.00, null);

select * from employee;

INSERT INTO `employee`
(`employee_name`,
`employee_title`,
`employee_dept`,
`full_of_part_time`,
`salary_or_hourly`,
`typical_hours`,
`annual_salary`,
`hourly_rate`)
VALUES
('AARON, JEFFERY M', 'SERGEANT', 'POLICE', 'F', 'Salary', null, 111444.00, null),
('AARON, KARI', 'POLICE OFFICER (ASSIGNED AS DETECTIVE)', 'POLICE', 'F', 'Salary', null, 94122.00, null),
('AARON, KIMBERLEI R', 'CHIEF CONTRACT EXPEDITER', 'DAIS', 'F', 'Salary', null, 118608.00, null),
('ABAD JR, VICENTE M', 'CIVIL ENGINEER IV', 'WATER MGMNT', 'F', 'Salary', null, 117072.00, null),
('ABARCA, EMMANUEL', 'CONCRETE LABORER', 'TRANSPORTN', 'F', 'Hourly', 40, null, 44.4),
('ABARCA, FRANCES J', 'POLICE OFFICER', 'POLICE', 'F', 'Salary', null, 68616.00, null),
('ABASCAL, REECE E', 'TRAFFIC CONTROL AIDE-HOURLY', 'OEMC', 'P', 'Hourly', 20, null, 19.86),
('ABBATACOLA, ROBERT J', 'ELECTRICAL MECHANIC', 'AVIATION', 'F', 'Hourly', 40, null, 50);

-- employee sql queries 
-- 1. Who is a salaried employee that makes less than 100K 
SELECT Employee_Name 
FROM employee
WHERE salary_or_hourly = 'Salary' AND annual_salary < 100000;

/*
2.	Of the Hourly employees, multiply their typical hours by 50 weeks
 and hourly rate to create a new column ‘estimated_annual_salary’, 
order employees by this column from the largest to smallest
*/

SELECT *, typical_hours*hourly_rate*50 AS estimated_annual_salary
FROM employee
WHERE salary_or_hourly = 'Hourly'
ORDER BY estimated_annual_salary DESC;

/*
3. using the LIKE operator select anyone with a tilte that contains "OFF"
*/

SELECT employee_name, employee_title
FROM employee
WHERE employee_title LIKE "%OFF%";

-- TASK 2 

/* 
Create a table RES01 - Who are the Top 10 Sidewalk Seating Restaurants (by area) in Manhattan,
 provide the name, address, borough, sidewalk seating area and whether they serve alcohol or not. 
 */
 
DROP table if exists RES01;

create table RES01
select 
restaurant_name, 
business_address, 
borough, 
sidewalk_dimensions_area,
qualify_alcohol
from nyc_applications_prep
where borough = 'Manhattan'
order by sidewalk_dimensions_area desc
limit 10;

select * from RES01;

/* 
Create a table RES02 – Who are the Top 10 Brooklyn restaurants that serve alcohol by sidewalk seating area, 
provide the name, borough, address, sidewalk seating area and alcohol. 
*/

DROP table if exists RES02;
create table RES02
select 
restaurant_name,
borough, 
business_address, 
sidewalk_dimensions_area, 
qualify_alcohol
from nyc_applications_prep
where borough = 'Brooklyn' and qualify_alcohol = 'yes'
order by sidewalk_dimensions_area desc
limit 10;

select * from RES02;

/* 
Create a table RES03 – Who are the Top 10 Restaurants by sidewalk seating area that serve alcohol and also contain the word ‘pizza’ (case-insensitive) in their name,
provide the name, address, borough, sidewalk seating area and whether they serve alcohol or not.
*/
drop table if exists RES03;
create table RES03
select 
restaurant_name,
business_address, 
borough,
sidewalk_dimensions_area,
qualify_alcohol
from nyc_applications_prep
where 
qualify_alcohol = 'yes' 
and 
lower(restaurant_name) like '%pizza%'
order by sidewalk_dimensions_area desc
limit 10;

select * from RES03;

/* 
Create a table RES04 - Who are the Bottom 10 Brooklyn restaurants that serve alcohol order by sidewalk seating area above 0,
provide the name, address, sidewalk seating area, borough and whether they serve alcohol or not.
*/

drop table if exists RES04;
create table RES04
select 
restaurant_name, 
business_address,
sidewalk_dimensions_area, 
borough, 
qualify_alcohol
from nyc_applications_prep
where borough = 'Brooklyn' and qualify_alcohol = 'yes' and sidewalk_dimensions_area > 0 
order by sidewalk_dimensions_area
limit 10;


select * from RES04;

/*
Create table RES05- Who are the Bottom 10 Sidewalk Seating Restaurants (by sidewalk area above 0) in Queens, 
provide the name, address, sidewalk seating area, borough, and whether they serve alcohol or not. 
*/

drop table if exists RES05;
create table RES05 
select 
restaurant_name, 
business_address, 
sidewalk_dimensions_area,
borough, 
qualify_alcohol
from nyc_applications_prep
where sidewalk_dimensions_area > 0 and borough = 'Queens'
order by sidewalk_dimensions_area 
limit 10;

select * from RES05;

/* 
Create table RES06 - Who are the Top 10 Restaurants by sidewalk seating area in Manhattan that serve alcohol and also start with the word ‘Thai’ (case-insensitive) in their name, 
provide the name, address, borough, sidewalk seating area and whether they serve alcohol or not. 

*/
drop table if exists RES06;
create table RES06
select 
restaurant_name,
business_address,
borough,
sidewalk_dimensions_area,
qualify_alcohol
from nyc_applications_prep
where 
borough = 'Manhattan' 
and 
lower(restaurant_name) like 'thai%'
order by sidewalk_dimensions_area desc
limit 10;

select * from RES06;

/*
Create table RES07 – Who are the Top 5 Restaurants by total_outside_area (sidewalk_dimensions_area + roadway_dimensions_area = total_outside_area), 
provide the name, address, sidewalk seating area, boro, roadway_dimensions_area, and whether they serve alcohol or not.
*/

drop table if exists RES07;
create table RES07
select 
restaurant_name,
business_address,
borough,
sidewalk_dimensions_area,
roadway_dimensions_area,
qualify_alcohol,
sidewalk_dimensions_area + roadway_dimensions_area as total_outside_area
from nyc_applications_prep
order by total_outside_area desc
limit 5;

select * from RES07;

/* 
Create table RES08 – Who are Restaurants in Brooklyn that report ‘both’ in seating_interest_sidewalk, but either sidewalk seating area or largest roadway seating area is zero, 
provide the name, address, boro, sidewalk seating area, and roadway seating area, sort the results by sidewalk area in ascending order.
*/
drop table if exists RES08;
create table RES08
select
restaurant_name, 
business_address,
borough, 
sidewalk_dimensions_area,
roadway_dimensions_area, 
qualify_alcohol
from nyc_applications_prep
where
borough = 'Brooklyn'
and 
seating_interest_sidewalk = 'both'
and
(sidewalk_dimensions_area = 0 
or 
roadway_dimensions_area = 0)
order by sidewalk_dimensions_area asc;

select * from RES08;
