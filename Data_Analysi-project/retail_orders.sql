-- 1-find Top 10 highest revenu generating products 
-- select * from df_orders 
-- select Product_Id, SUM(cost_price) as sales
-- from df_orders
-- group by Product_Id
-- order by sales desc limit 10

-- 2-find top 5 highest selling products in each region
-- select distinct region from df_orders
-- with cte as(
-- select region,Product_Id, SUM(cost_price) as sales
-- from df_orders
-- group by region, Product_Id)
-- select * from (
-- select * 
-- ,row_number() over(partition by region order by sales desc) as rn 
-- from cte ) A where rn<=5

-- 3-find month over month growth comparison for 2022 and 2023 sales  eg :2022 vs jan 2023
-- select * from df_orders
-- with cte as (
-- select year(Order_Date) as orderyear, month(Order_Date) as ordermonth,
-- sum(cost_price) as sales 
-- from df_orders
-- group by year(Order_Date),  month(Order_Date)
-- -- order by year(Order_Date),  month(Order_Date)
-- )
-- select ordermonth 
-- ,sum(case when orderyear=2022 then sales else 0 end)as sales_2022
-- ,sum(case when orderyear=2023  then sales else 0 end)as sales_2023
-- from cte 
-- group by ordermonth
-- order by ordermonth


-- 4-for each category which month had highest sales
-- select * from df_orders
-- with cte as(
-- SELECT category, DATE_FORMAT(Order_Date, '%Y%m') AS new_year_month, sum(cost_price) as sales
-- FROM df_orders
-- group by category,DATE_FORMAT(Order_Date, '%Y%m')
-- order by category,DATE_FORMAT(Order_Date, '%Y%m')
-- )
-- select * from(
-- SELECT *, 
-- ROW_NUMBER() OVER (PARTITION BY category ORDER BY sales DESC) AS rn
-- FROM 
-- cte
-- ) a where rn=1

-- -5 which sub category had the highest growth by profit in  2023 compare to 2022
--  select * from df_orders

with cte as (
select Sub_Category, year(Order_Date) as orderyear,
sum(cost_price) as sales 
from df_orders
group by Sub_Category, year(Order_Date)
-- order by year(Order_Date),  month(Order_Date)
)
, cte2 as (
select Sub_Category 
,sum(case when orderyear=2022 then sales else 0 end)as sales_2022
,sum(case when orderyear=2023  then sales else 0 end)as sales_2023
from cte 
group by Sub_Category
)
select *
, (sales_2022-sales_2023)*100/sales_2022 as Sales_Growth
from cte2
order by Sales_Growth desc limit 5
















