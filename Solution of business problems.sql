-- Solution of business problems using SQL queries on superstore sales data


-- Q.1 Creating a view to calculate overall business performance 
-- metrics: revenue, profit, total orders, average order value, and profit margin.

create view overall_kpi as
select 
	sum(Sales) as revenue,
    sum(Profit) as total_profit,
    count(distinct OrderID) as total_orders,
    sum(Sales) / count(distinct OrderID) as avg_order_value,
    (sum(Profit) / sum(Sales)) * 100 as profit_margin
from Sales_data;

-- for viewing data
select * from overall_kpi;



-- Q.2 Creating a view to analyze monthly performance

create view monthly_performance as 
 select
 	date_format(orderDate, '%Y-%m') as month,
      sum(Sales) as total_sales,
      sum(Profit) as total_profit,
      round(sum(Profit) / sum(Sales) * 100, 2) as profit_margin
from sales_data
group by date_format(orderDate, '%Y-%m')
order by month;

-- for showing view
select * from monthly_performance;



-- Q.3 write the query for the month with the highest revenue

select
	date_format(orderDate, '%Y-%m') as month,
    sum(Sales) as revenue
from sales_data
group by date_format(orderDate, '%Y-%m')
order by revenue desc
limit 1;



-- Q.4 write the query to find the total sales and profit for each category, ordered by total sales in descending order. 

with category_sales as (
	select
		Category,
        sum(Sales) as total_sales,
        sum(Profit) as total_profit
	from sales_data
    group by Category
)
select * from category_sales
order by total_sales desc;



-- Q.5 write the query to find the sub-category with the lowest profit.

select
	SubCategory,
    sum(Profit) as total_profit
from sales_data
group by SubCategory
having sum(Profit) < 0
order by total_profit;



-- Q.6 write the query to find the top 5 products by revenue.

create view top_5_product as
select 
	SubCategory,
	sum(Sales) as revenue
from sales_data
group by SubCategory
order by revenue desc
limit 5;



-- Q.7 write the query to find the region with the highest profit.

select
	Region,
    sum(Sales) as revenue,
    sum(Profit) as total_profit
from sales_data
group by Region
order by total_profit desc;



-- Q.8 write the query to find the state with the lowest profit.

select
	State,
    sum(Sales) as revenue,
    sum(Profit) as total_profit
from sales_data
group by State
having sum(Profit) < 0 
order by total_profit;



--Q.9 write the query to find the average profit for each discount level.

select
	Discount,
    avg(Profit) as avg_profit
from sales_data
group by  Discount
order by Discount;



-- Q.10 write the query to find the sub-category with the highest average discount and lowest total profit.

select 
	SubCategory,
    avg(Discount) as avg_discount,
    sum(Profit) as total_profit
from sales_data
group by SubCategory
having avg(Discount) > 0.2 and sum(Profit) < 0;



-- Q.11 write the query to find the profit margin for each category.

select
	Category,
    round(sum(Profit) / sum(Sales) * 100 , 2) as profit_margin
from sales_data
group by Category
order by profit_margin desc;



-- Q.12 write the query to find the total profit for each shipping mode.

select
	ShipMode,
    sum(Profit) as total_profit
from sales_data
group by ShipMode
order by total_profit desc;



-- Q.13 write the query to find the average delivery time (in days).

select
	avg(datediff(ShipDate, orderDate)) as avg_delivery_days
from sales_data;



-- Q.14 write the query to find the running total of sales over time.

select
	orderDate,
    sum(Sales) over (order by orderDate) as running_total
from sales_data;



-- Q.15 write the query to find the rank of each category based on total revenue.

select
	Category,
    sum(Sales) as revenue,
    rank() over(order by sum(Sales) desc) as rank_position
from sales_data
group by Category;



-- Q.16 write the query to find the top 5 sub-categories by revenue, along with their rank positions.

select * 
from(
	select
		SubCategory,
        sum(Sales) as revenue,
        rank() over(order by sum(Sales) desc) as rnk_position
	from sales_data
    group by SubCategory
) ranked
where rnk_position <= 5;















