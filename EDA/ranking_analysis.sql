/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- which 5 products generate the highest revenue?
SELECT TOP 5
	COALESCE(p.product_category_name, 'Unclassified Products') product_category_name,
	SUM(price + freight_value) total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
	ON s.product_id = p.product_id
WHERE s.order_status = 'delivered'
GROUP BY COALESCE(p.product_category_name, 'Unclassified Products')
ORDER BY total_revenue DESC

-- what are the 5 worst performing products in terms of sales?
SELECT *
FROM (

SELECT
	COALESCE(p.product_category_name, 'Unclassified Products') product_category_name,
	SUM(price + freight_value) total_revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(price + freight_value) ASC) rank_products
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
	ON s.product_id = p.product_id
WHERE s.order_status = 'delivered'
GROUP BY COALESCE(p.product_category_name, 'Unclassified Products')
) t WHERE t.rank_products <= 5

-- Find the top 10 customers who have generated thehighest revenue
SELECT TOP 10
	COALESCE(c.customer_unique_id, 'Unknown') customer_unique_id,
	SUM(price + freight_value) total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
	ON s.customer_id = c.customer_id
WHERE s.order_status = 'delivered'
GROUP BY COALESCE(c.customer_unique_id, 'Unknown')
ORDER BY total_revenue DESC

-- The 3 customers with the least orders placed
SELECT TOP 3
	COALESCE(c.customer_unique_id, 'Unknown') customer_unique_id,
	COUNT(DISTINCT s.order_id) total_orders
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_id = c.customer_id
GROUP BY COALESCE(c.customer_unique_id, 'Unknown')
ORDER BY total_orders 