use medicare; 
select * from nc_scripts limit 10;

select * from opioid_list;

select * from nc_phys_education;

CREATE TEMPORARY TABLE top_opioid_cost AS
SELECT 
    'opiate' as drug_type, 
    drug_name, 
    generic_name,
    AVG(total_drug_cost / total_day_supply) as avg_daily_drug_cost
FROM (
    SELECT n.*
    FROM nc_scripts AS n
    JOIN opioid_list AS o
    ON n.drug_name = o.drug_name
    AND n.generic_name = o.generic_name
) AS opioid_script
GROUP BY 1, 2, 3
ORDER BY avg_daily_drug_cost DESC
LIMIT 1;

select * from top_opioid_cost;