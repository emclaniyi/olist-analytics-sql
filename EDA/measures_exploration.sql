/*
================================================================
Measures Exploration (Key metrics)
================================================================
Purpose:
	- To calculate aggregated metrics (e.g., totals, averages) for quick insights.
	- To identify overall trends or spot anomalies.

SQL Functions Used:
	- COUNT(). SUM(), AVG()
==================================================================
*/


-- Find the Total Sales
SELECT
	SUM(price + freight_value) total_sales
FROM gold.fact_sales

-- Find how many items are sold
SELECT
	COUNT(order_item_id) total_items
FROM gold.fact_sales

-- Find the average selling price
SELECT
	AVG(price) avg_selling_price
FROM gold.fact_sales

-- Find the total number of orders
SELECT
	COUNT(DISTINCT order_id) total_orders
FROM gold.fact_sales

-- Find the total number of products
SELECT
	COUNT(DISTINCT product_id) total_products
FROM gold.dim_products

SELECT
	COUNT(DISTINCT product_id) total_products
FROM gold.fact_sales

-- Find the total number of customers
SELECT
	COUNT(customer_unique_id) total_customers
FROM gold.dim_customers

-- Find the total number of customers that has placed an order
SELECT 
	COUNT(DISTINCT dc.customer_unique_id) total_customers
FROM gold.fact_sales fs
JOIN gold.dim_customers dc
  ON fs.customer_id = dc.customer_id;


-- GENERATE A REPORT THAT SHOWS ALL KEY METRICS OF THE BUSINESS
SELECT 'Total Sales' AS measure_name, SUM(price + freight_value) total_sales FROM gold.fact_sales
UNION ALL
SELECT 'Total Items' AS measure_name, COUNT(order_item_id) total_items FROM gold.fact_sales
UNION ALL
SELECT 'Average Selling Price' AS measure_name, AVG(price) avg_selling_price FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders' AS measure_name, COUNT(DISTINCT order_id) total_orders FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products' AS measure_name, COUNT(DISTINCT product_id) total_products FROM gold.dim_products
UNION ALL
SELECT 'Total Nr. Customers' AS measure_name, COUNT(customer_unique_id) total_customers FROM gold.dim_customers
