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

