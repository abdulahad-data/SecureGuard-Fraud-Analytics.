-- Creating and selecting Schema

CREATE SCHEMA Finance;
USE Finance;

-- Creating the main Transaction Table

CREATE TABLE cc_data(
idx INT,
trans_date_trans_time DATETIME,
cc_num BIGINT,
merchant VARCHAR(255),
category VARCHAR(100),
amt DECIMAL(10,2),
first_name VARCHAR(100),
last_name VARCHAR(100),
gender CHAR(1),
street VARCHAR(255),
city VARCHAR(100),
state CHAR(2),
zip VARCHAR(20),
lat DECIMAL(10,6),
longitude DECIMAL(10,6),
city_pop INT,
job VARCHAR(255),
dob DATE,
trans_num VARCHAR(100),
unix_time INT,
merch_lat DECIMAL(10,6),
merch_long DECIMAL(10,6),
is_fraud INT
);

-- Creating the location refrence table

CREATE TABLE location_data(
cc_num BIGINT,
lat DECIMAL(10,6),
longitude DECIMAL(10,6)
);

SHOW VARIABLES LIKE "secure_file_priv";

-- Loading the Transaction DATA 

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cc_data.csv'
INTO TABLE cc_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    idx,
    @v_trans_date, 
    cc_num, 
    merchant, 
    category, 
    amt, 
    first_name, 
    last_name, 
    gender, 
    street, 
    city, 
    state, 
    zip, 
    lat, 
    longitude, 
    city_pop, 
    job, 
    @v_dob, 
    trans_num, 
    unix_time, 
    merch_lat, 
    merch_long, 
    is_fraud
)
SET 
    trans_date_trans_time = STR_TO_DATE(@v_trans_date, '%d-%m-%Y %H:%i'),
    dob = STR_TO_DATE(@v_dob, '%d-%m-%Y');
    
-- Loading the location DATA 
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/location_data.csv'
INTO TABLE location_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Total transactions

SELECT COUNT(*) AS total_transactions
FROM cc_data;

-- Top 10 most frequent merchants

SELECT merchant, 
COUNT(*) AS transaction_count
FROM cc_data
GROUP BY merchant
ORDER BY transaction_count DESC
LIMIT 10;

-- Average transaction amount by category

SELECT 
category,
ROUND(AVG(amt),2) AS average_amount
FROM cc_data
GROUP BY category
ORDER BY average_amount DESC;

-- Fraud count and Percentage

SELECT
SUM(is_fraud) AS total_fraud_trnsactions,
ROUND((SUM(is_fraud) / COUNT(*)) * 100,3) AS fraud_percentage
FROM cc_data;

-- Realtional join for coordinates

SELECT
c.trans_num,
c.cc_num,
l.lat AS location_lat,
l.longitude AS location_long
FROM cc_data c
INNER JOIN location_data l
ON c.cc_num = l.cc_num
LIMIT 100;

-- City with Highest population

SELECT DISTINCT
c.city,
c.city_pop
FROM location_data l
INNER JOIN cc_data c
ON l.cc_num = c.cc_num
ORDER BY c.city_pop DESC
LIMIT 1;

-- Earliest and Latest transacction Date 

SELECT
MIN(trans_date_trans_time) AS earliest_transaction,
MAX(trans_date_trans_time) AS latest_transaction
FROM cc_data;

-- Total Amount spent Across All Transactions 

SELECT 
ROUND(SUM(amt),2) AS tottal_amount_spent
FROM cc_data;

-- Number of Transaction in Each Category 

SELECT
category,
COUNT(*) AS transaction_count
FROM cc_data
GROUP BY category
ORDER BY transaction_count DESC;

-- Average Transaction AMount fro each gender

SELECT 
gender,
ROUND(AVG(amt),2) AS average_amount
FROM cc_data
GROUP BY gender;

-- Day of the week with the highest average transaction amount

SELECt 
DAYNAME(trans_date_trans_time) AS day_of_week,
ROUND(AVG(amt),2) AS average_amount
FROM cc_data
GROUP BY day_of_week
ORDER BY average_amount DESC
LIMIT 1;
