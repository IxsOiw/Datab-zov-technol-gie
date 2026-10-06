-- Uloha 1

CREATE VIEW high_value_customers AS
SELECT t1.customer_id,
       t1.customer_name,
       SUM(t2.sales) AS total_sales
FROM customers t1
INNER JOIN orders t2
        ON t1.customer_id = t2.customer_id
GROUP BY t1.customer_id, t1.customer_name
HAVING SUM(t2.sales) > 2000;

SELECT *
FROM high_value_customers;
