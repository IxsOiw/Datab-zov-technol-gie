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

-- Uloha 2

create view regional_monthly_sales as 
select t1.region, 
       date_trunc('month', t2.order_date) as month,
       sum(sales) as mouthly_sales 
from customers t1
inner join orders t2 
         on t1.customer_id = t2.customer_id
group by t1.region, date_trunc('month',order_date)
order by t1.region, month;

select * from regional_monthly_sales
where region = 'West'

-- Uloha 3

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

SELECT * FROM orders
WHERE customer_id = 'C001';

-- Uloha 4

CREATE INDEX idx_orders_order_date
ON orders (order_date);

SELECT DATE_TRUNC('month', order_date)::date AS month,
       SUM(sales) AS sum
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- Uloha 5

create index idx_orders_region_category
on orders(customer_id,order_date);

SELECT o.*,
       c.customer_name,
       c.region
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id
WHERE c.region = 'West' and customer_name = 'Customer_25'
  AND o.order_date >= DATE '2024-01-01';


