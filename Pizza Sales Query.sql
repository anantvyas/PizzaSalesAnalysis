--A. We will analyze the key indicators for our pizza sales data to gain insights into the business performance.

--1.Total Revenue:- The sum of the total prize of all pizza sales order.
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

--2.Average Order Value:- The average amount spent per order, calculated by dividing the total revenue by the total number of orders.
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales

--3.Total Pizzas Sold:- The sum of quantities of all pizzas sold.
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales

--4.Total Orders:- The total number of orders placed.
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales

--5.Average Pizzas per Order:- It is calculated by dividing the total number of pizzas sold by the total number of orders.
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales

--B. Daily Trend for Total Orders
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

--C. Hourly Trend for Orders:- At which volume of hours there are peak orders.
SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

--D. % of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

--E. % of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

--F. Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--G. Top 5 Best Sellers by Total Pizzas Sold
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

--H. Bottom 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

--RESULTS:-
--1. The maximum number of pizzas sold is on Friday.
--2. The peak hours of pizzas sold is between (12-1)pm and from (5-7)pm.
--3. Classic pizzas are sold the most and generated the maximum revenue.
--4. Pizza size L has been sold the most as it is the most preferred size in the family or friends.
--5. The Classic Deluxe pizza has been sold the most.
--6. The Brie Carre pizza has been sold the least among all the pizzas.






