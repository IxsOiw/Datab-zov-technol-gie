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

-- Uloha 7

SELECT c.customer_name, COUNT(o.customer_id)
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name;

-- Uloha 8

SELECT p.category, AVG(o.discount) AS priemerna_zlava
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

-- Uloha 9 

SELECT c.customer_id, c.customer_name, SUM(o.sales) AS celkova_hodnota_nakupov
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.sales) > 2000;

-- Uloha 10

SELECT c.region,
       SUM(o.sales) AS celkova_hodnota_predaja,
       ROUND(AVG(o.discount),2) AS priemerna_zlava,
       COUNT(o.order_id) AS pocet_objednavok
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region;
