/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieve a list of unique states from which customers originate
SELECT DISTINCT 
	customer_state
FROM gold.dim_customers
ORDER BY customer_state

-- Retrieve a list of unique categories
SELECT DISTINCT 
	product_category_name
FROM gold.dim_products