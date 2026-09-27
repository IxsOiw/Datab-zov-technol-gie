-- Uloha 1
SELECT o.order_id,c.customer_name,(sales * discount) as hodnota_predaja 
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE (sales * discount) > 500
ORDER BY hodnota_predaja DESC;
