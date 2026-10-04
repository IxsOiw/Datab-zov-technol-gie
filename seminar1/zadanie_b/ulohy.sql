-- Uloha 1

SELECT product_name, total_amount
FROM flourmills_sales
WHERE total_amount > (
  SELECT AVG(total_amount)
  FROM flourmills_sales
);

-- Uloha 2

SELECT sales_id,sale_date ,region, product_category 
FROM flourmills_sales
WHERE product_category = (
    SELECT product_category
    FROM flourmills_sales
    GROUP BY product_category
    ORDER BY SUM(quantity_sold) DESC
    LIMIT 1
)
ORDER BY sales_id ASC;

-- Uloha 3

SELECT product_name, total_amount,( 
  SELECT AVG(total_amount) from flourmills_sales) as avg_amount
from flourmills_sales
WHERE total_amount = 9511208.41;

-- Uloha 4

SELECT product_name, total_amount, total_amount / ( 
  SELECT (sum(total_amount)) from flourmills_sales 
) as amount_share
from flourmills_sales
Limit 5;

-- Uloha 5

-- pokus 1 tak trochu som iba spocital predaje za dany mesiac ale zabudol spocitat hodnotu predajov 

select * 
FROM(
  SELECT EXTRACT(MONTH FROM sale_date) AS mouth,
        COUNT(*) AS mouthly_sales 
  FROM flourmills_sales
  GROUP BY EXTRACT(MONTH FROM sale_date)
  ORDER BY mouth
);

-- pokus 2 uz som spocital sum(total_amount)

SELECT month, monthly_sales
FROM (
    SELECT EXTRACT(MONTH FROM sale_date) AS month,
           SUM(total_amount) AS monthly_sales
    FROM flourmills_sales
    GROUP BY EXTRACT(MONTH FROM sale_date)
) AS monthly
ORDER BY month DESC;

-- Uloha 6

select * from 
(
  select
    product_category, 
    sum(total_amount) total_amount
  from flourmills_sales
  GROUP by product_category
) as category_sales
WHERE total_amount > 50000000
order by total_amount desc;

-- uloha 7

SELECT
    t1.product_name,
    t1.product_category,
    t1.total_amount
FROM flourmills_sales AS t1
WHERE t1.total_amount > (
    SELECT AVG(t2.total_amount)
    FROM flourmills_sales AS t2
    WHERE t2.product_category = t1.product_category
);


SELECT COUNT(*) AS pocet
FROM flourmills_sales AS t1
WHERE t1.total_amount > (
    SELECT AVG(t2.total_amount)
    FROM flourmills_sales AS t2
    WHERE t2.product_category = t1.product_category
);


-- Uloha 8

SELECT
    t1.product_name,
    t1.region,
    t1.total_amount,
    (
        SELECT MIN(t2.total_amount)
        FROM flourmills_sales AS t2
        WHERE t2.region = t1.region
    ) AS region_min_amount
FROM flourmills_sales AS t1;
