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


-- Uloha 9

select customer_id, sum(sales) from orders
group by customer_id;

--  CUST00733   | 33653.49

DROP PROCEDURE get_customer_sales(character varying)

CREATE OR REPLACE PROCEDURE get_customer_sales(
  p_customer_id VARCHAR)
LANGUAGE plpgsql
AS $procedure$
DECLARE
  p_total numeric default NULL;
BEGIN
    SELECT SUM(sales)
    INTO p_total
    FROM orders
    WHERE orders.customer_id = p_customer_id;

    RAISE NOTICE '% -> %', p_customer_id, p_total;
END;
$procedure$;

CALL get_customer_sales('CUST00733');

-- Uloha 10

/*
select region,
       sum(sales) as spolu,
       sum(sales) * (1 - 0.10) as po_zlave
from orders
group by region;

 region  |    spolu    |   po_zlave    
---------+-------------+---------------
 South   | 25135562.15 | 22622005.9350
 West    | 25336941.56 | 22803247.4040
 East    | 24804536.17 | 22324082.5530
 Central | 25018947.91 | 22517053.1190

 Central | 25018947.91
 East    | 24804536.17
 South   | 25135562.15
 West    | 16623610.54

 */

DROP PROCEDURE apply_regional_discount(character varying,numeric) 

CREATE OR REPLACE PROCEDURE apply_regional_discount(
  p_region VARCHAR,
  p_discount_rate NUMERIC
)
LANGUAGE plpgsql
AS $procedure$
DECLARE
  v_rows INTEGER;
BEGIN
    UPDATE orders
    SET sales = sales * (1 - p_discount_rate)
    WHERE region = p_region;

    GET DIAGNOSTICS v_rows = ROW_COUNT;

    RAISE NOTICE ' % -> % -> rows ? %',
                 p_discount_rate, p_region, v_rows;
END;
$procedure$;

CALL apply_regional_discount('West', 0.10);
-- NOTICE: 0.10 -> West -> rows ? 25231

select count(*) from orders where region = 'West'
--  rows 25231

select region, round(sum(sales), 2) as spolu
from orders
group by region
order by region;

-- Uloha 11
select sum(sales) from orders 
where order_date BETWEEN '2024-01-01' and '2024-03-31'
--  2018766.23


create or replace procedure get_sales_between
(
  start_date      DATE,
  end_date        DATE
)
language plpgsql
as $procedure$
DECLARE
  p_total numeric default null;
begin
  select sum(sales)
  into p_total
  from orders
  where order_date BETWEEN start_date and end_date;

  Raise notice 'start -> % end -> % total -> %',start_date, end_date, p_total;
end;
$procedure$;

CALL get_sales_between('2024-01-01','2024-03-31')
-- NOTICE:  start -> 2024-01-01 end -> 2024-03-31 total -> 2018766.23
