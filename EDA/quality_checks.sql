SELECT 
    f.product_id,
    COUNT(*) AS occurrences
FROM silver.olist_order_items f
LEFT JOIN silver.olist_products p ON f.product_id = p.product_id
WHERE p.product_id IS NULL
GROUP BY f.product_id
ORDER BY occurrences DESC

SELECT 
    order_status, 
    COUNT(*) AS count_of_null_products
FROM gold.fact_sales
WHERE product_id IS NULL
GROUP BY order_status;

SELECT 
    product_id,
    COALESCE(product_category_name_english, 'others') as category_name -- Forces NULLs into 'others'
FROM silver.olist_products;

SELECT s.product_id, COUNT(*) AS count_missing
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
  ON s.product_id = p.product_id
WHERE p.product_id IS NULL
GROUP BY s.product_id
ORDER BY count_missing DESC;


SELECT DISTINCT s.customer_id
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
    ON s.customer_id = c.customer_id
WHERE c.customer_unique_id IS NULL;
