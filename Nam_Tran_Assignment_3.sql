drop schema if exists assignment_3;
create schema assignment_3;
use assignment_3;

select * from loan limit 10;
# Result 0: Top 5 purposes of verified loans 

select purpose, count(*)
from assignment_3.loan
where verification_status = 'verified' 
group by purpose 
order by 2 desc
limit 5;

# RESULT 1: top default rates by purpose 
# from loan table, keep verified loans only , 
# top 5 purposes, ranking their average default rate 

SELECT 
    purpose, AVG(bad_loan) AS default_rate
FROM
    assignment_3.loan
WHERE
    verification_status = 'verified'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5; 

# RESULT 2: top default rates by state 
# keep verified loans only
# among states with more than 1000 loans, 
# find the top 5 states witht eh highest default rate

SELECT 
    addr_state, AVG(bad_loan) AS default_rate
FROM
    assignment_3.loan
WHERE
    verification_status = 'verified'
GROUP BY 1
HAVING COUNT(addr_state) > 1000
ORDER BY 2 DESC
LIMIT 5; 

# RESULT 3: Average income and loan amount by purpose 
# top 5 purposes by ranking their aavg loan amount by DESC
# for each purpose 
## avg annual income 
## avg default rate 

SELECT 
    purpose,
    AVG(annual_inc) avg_income,
    AVG(loan_amnt) avg_loan_amnt,
    AVG(bad_loan) default_rate
FROM
    assignment_3.loan
WHERE
    verification_status = 'verified'
GROUP BY purpose
ORDER BY avg_loan_amnt DESC
LIMIT 5; 

# RESULT 4: CONFUSION MATRIX
SELECT 
    id, pred, bad_loan
FROM
    test_data;

# RESULT 5: Your analysis 

# Top 10 states with the highest interest rates and how did it affect the rent/own percentage

SELECT 
    addr_state,
    ROUND(AVG(int_rate), 2) avg_int_rate,
    ROUND(AVG(CASE
                WHEN home_ownership = 'RENT' THEN 1
                ELSE 0
            END),
            2) rent_own_ratio
FROM
    loan
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

