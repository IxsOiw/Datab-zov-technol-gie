-- Uloha 1

with daily_sales as 
(
  select sale_date, sum(total_amount) as total_daily_sales from flourmills_sales
  group by sale_date
)
select * from daily_sales
where total_daily_sales > 30000000
order by total_daily_sales desc
limit 5;

-- Uloha 2

with category_sales as 
(
  select product_category, sum(total_amount) as celkovo from flourmills_sales
  group by product_category
)
select * from category_sales
order by celkovo desc;

-- Uloha 3
WITH cte_1 AS (
    SELECT
        product_category,
        product_name,
        SUM(total_amount) AS total_product_sales
    FROM flourmills_sales
    GROUP BY product_category, product_name
),
cte_2 AS (
    SELECT
        product_category,
        product_name,
        total_product_sales,
        RANK() OVER (
            PARTITION BY product_category
            ORDER BY total_product_sales DESC
        ) AS category_rank
    FROM cte_1
)
SELECT
    product_category,
    product_name,
    total_product_sales,
    category_rank
FROM cte_2
WHERE category_rank <= 3
ORDER BY product_category, category_rank;

-- Uloha 4 

WITH cte_1 AS (
    SELECT customer_type, SUM(total_amount) AS revenue
    FROM flourmills_sales
    GROUP BY customer_type
),
cte_2 AS (
    SELECT
        customer_type,
        revenue,
        SUM(revenue) OVER () AS total_revenue,
        ROUND(revenue * 100.0 / SUM(revenue) OVER (), 2) AS revenue_percentage
    FROM cte_1
)
SELECT *
FROM cte_2;

-- Uloha 5

WITH cte AS (
    SELECT
        customer_id,
        product_name,
        sale_date,
        total_amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY sale_date DESC
        ) AS rn
    FROM flourmills_sales
)
SELECT
    customer_id,
    product_name,
    sale_date,
    total_amount
FROM cte
WHERE rn = 1
ORDER BY customer_id ASC
limit 5;

-- Uloha 6

WITH RECURSIVE cte_1 AS (
    SELECT
        MIN(sale_date) AS start_date,
        MAX(sale_date) AS end_date
    FROM flourmills_sales
),
cte_2 AS (
    SELECT start_date AS sale_date, end_date
    FROM cte_1

    UNION ALL

    SELECT sale_date + 1, end_date
    FROM cte_2
    WHERE sale_date < end_date
)
SELECT sale_date
FROM cte_2
ORDER BY sale_date;

-- Uloha 7 

WITH RECURSIVE cte_1 AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS month,
        SUM(total_amount) AS revenue
    FROM flourmills_sales
    GROUP BY DATE_TRUNC('month', sale_date)
),
cte_2 AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY month) AS rn,
        month,
        revenue
    FROM cte_1
),
cte_3 AS (
    SELECT
        rn,
        month,
        revenue,
        revenue AS cumulative_revenue
    FROM cte_2
    WHERE rn = 1

    UNION ALL

    SELECT
        c2.rn,
        c2.month,
        c2.revenue,
        c3.cumulative_revenue + c2.revenue AS cumulative_revenue
    FROM cte_3 AS c3
    JOIN cte_2 AS c2
        ON c2.rn = c3.rn + 1
)
SELECT
    month,
    cumulative_revenue
FROM cte_3
WHERE cumulative_revenue >= 500000000
ORDER BY month
LIMIT 1;
