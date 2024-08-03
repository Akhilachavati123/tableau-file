-- EXPLORATORY DATA ANALYSIS
use amazonsales;

select* from amazonsalesdata;

-- Highest Revenue and Profit per category
select `Item Type`, max(`Total Revenue`) as max_revenue, max(`Total Profit`) as max_profit
from amazonsalesdata
group by `Item Type`;

-- Summary statistics for numerical columns
select 
    count(*) as total_records,
    avg(`Units Sold`) as avg_units_sold,
    avg(`Unit Price`) as avg_unit_price,
    avg(`Total Revenue`) as avg_total_revenue,
    avg(`Total Cost`) as avg_total_cost,
    avg(`Total Profit`) as avg_total_profit
from amazonsalesdata;

-- Total sales revenue by country
select Country, sum(`Total Revenue`) as total_sales
from amazonsalesdata
group by Country
order by total_sales;

-- Average Quantity Ordered per Category
select `Item Type`, avg(`Units Sold`) as avg_quantity
from amazonsalesdata
group by `Item Type`;

-- Top 5 products that have generated the highest revenue
select `Item Type`, sum(`Total Revenue`) as revenue_generated
from amazonsalesdata
group by `Item Type`
order by revenue_generated desc
limit 5;

-- Monthly sales trend over time
select date_format(`Order Date`, '%Y-%m') as months, sum(`Total Revenue`) as monthly_sales
from amazonsalesdata
group by months
order by monthly_sales desc;

-- Countries with the highest total orders
with ranks_table
as(
select Country, `Item Type`, sum(`Units Sold`) as total_orders,
rank() over(partition by Country order by sum(`Units Sold`) desc) as ranks
from amazonsalesdata
group by Country, `Item Type`
)
select Country, `Item Type`, total_orders
from ranks_table
where ranks =1
order by total_orders desc;

-- The month with the highest number of orders
select `Item Type`, sum(`Units Sold`) as total_orders,
extract(month from `Order Date`) as months
from amazonsalesdata
group by months, `Item Type`
order by total_orders desc
limit 1;

with ranks_table as(
select `Item Type`, sum(`Units Sold`) as total_orders,
extract(month from `Order Date`) as months,
rank() over(partition by `Item Type` order by sum(`Units Sold`)) as ranks
from amazonsalesdata
group by months, `Item Type`
)
select months, `Item Type`, total_orders
from ranks_table
where ranks = 1
limit 1;

select `Order Date`,
str_to_date(`Order Date`, '%m/%d/%Y')
from amazonsalesdata;

update amazonsalesdata
set `Order Date` = str_to_date(`Order Date`, '%m/%d/%Y');

alter table amazonsalesdata
modify column `Order Date` date;

select `Ship Date`,
str_to_date(`Ship Date`, '%m/%d/%Y')
from amazonsalesdata;

update amazonsalesdata
set `Ship Date` = str_to_date(`Ship Date`, '%m/%d/%Y');

alter table amazonsalesdata
modify column `Ship Date` date;

-- Profit margin percentage for each sale(Profit divided by Sales)
select `Item Type`, (sum(`Total Profit`)/sum(`Total Revenue`))*100 as profit_margin_percentage
from amazonsalesdata
group by `Item Type`
order by profit_margin_percentage desc;

-- High priority orders by country
select Country, count(*) as high_priority_orders
from amazonsalesdata
where `Order Priority` = 'H'
group by Country
order by high_priority_orders;

-- Average shipping time by country
select Country, round(avg(datediff(`Ship Date`, `Order Date`)),2) as avg_shipping_time
from amazonsalesdata
group by Country
order by avg_shipping_time;

select `Order Date`, `Ship Date`
from amazonsalesdata
where Country = 'Zambia';

-- Total sales revenue by sales channel
select `Sales Channel`, sum(`Total Revenue`) as total_sales
from amazonsalesdata
group by `Sales Channel`
order by total_sales desc;




