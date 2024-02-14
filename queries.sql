SELECT *
FROM pizza_sales;

SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS Avg_Order_Value
FROM pizza_sales;

SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

SELECT ROUND(SUM(quantity) / COUNT(DISTINCT order_id),2) AS Avg_Pizzas_per_Order
FROM pizza_sales;

### POWER BI ###
# daily trend for total orders
SELECT 
	DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Order_Day,
	COUNT(*) AS Total_Orders
FROM
    (SELECT DISTINCT order_id, order_date FROM pizza_sales) AS Unique_Orders
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY Total_Orders DESC;
    
SELECT
    MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Order_Month,
    COUNT(*) AS Total_Orders
FROM
    (SELECT DISTINCT order_id, order_date FROM pizza_sales) AS Unique_Orders
# WHERE MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) = 7 - we can use this for the query below to filter down even further
GROUP BY MONTH(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY Total_Orders DESC;

SELECT 
	pizza_category, 
	ROUND(SUM(total_price),2) AS Total_Sales, 
    ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales),2) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

SELECT 
	pizza_size, 
	ROUND(SUM(total_price),2) AS Total_Sales, 
    ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE EXTRACT(QUARTER FROM STR_TO_DATE(order_date, '%d-%m-%Y')) = 1),2) AS PCT
FROM pizza_sales
WHERE EXTRACT(QUARTER FROM STR_TO_DATE(order_date, '%d-%m-%Y')) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

SELECT pizza_name, ROUND(SUM(total_price),2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

SELECT pizza_name, ROUND(SUM(total_price),2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

SELECT pizza_name, ROUND(SUM(quantity),2) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5;

SELECT pizza_name, ROUND(SUM(quantity),2) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC
LIMIT 5;

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;





