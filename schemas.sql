--Database:  use sales_super_data;

-- schema for sales store data table
create table sales_store_data (
	order_id varchar(30),
	order_date date,
	ship_date date,
	ship_mode varchar(50),
	segment varchar(30),
	state varchar(30),
	country varchar(30),	
    region varchar(30),
	category varchar(50),
	sub_category varchar(50),
	sales decimal(10,2),
	quantity int,
	discount decimal(5,2),
	profit decimal(10,2)
);


-- check the secure_file_priv variable to determine the directory for loading data
SHOW VARIABLES LIKE 'secure_file_priv';


-- load data from the CSV file into the sales_store_data table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/superstore_dataset.csv'
INTO TABLE sales_store_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,@order_date,@ship_date,ship_mode,
segment,state,country,region,category,
sub_category,
sales,quantity,discount,profit)
SET
order_date = STR_TO_DATE(@order_date, '%m/%d/%Y'),
ship_date = STR_TO_DATE(@ship_date, '%m/%d/%Y');



select * from sales_store_data limit 10;