-- Uloha 1

SELECT o.order_id,c.customer_name,(sales * discount) as hodnota_predaja 
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE (sales * discount) > 500
ORDER BY hodnota_predaja DESC;

-- Uloha 2

SELECT o.order_id,c.customer_name,p.category,(sales * discount) as hodnota_predaja 
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON o.product_id = p.product_id;

-- Uloha 3

SELECT c.region, (sales * discount) as hodnota_predaja 
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id

-- Uloha 4

SELECT p.product_name,(sales * discount) as hodnota_predaja 
FROM orders o 
INNER JOIN products p ON o.product_id = p.product_id;

-- Uloha 5

SELECT c.customer_name,o.order_id,(sales * discount) as hodnota_predaja 
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- Uloha 6

SELECT c.region, SUM(o.sales * o.discount) as hodnota_predaja
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region;
