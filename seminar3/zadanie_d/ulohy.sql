--- Uloha 1

 SELECT
    customer_name,
    order_id,
    order_date
FROM (
    SELECT
        c.customer_name,
        o.order_id,
        o.order_date,
        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date DESC, o.order_id DESC
        ) AS rn
    FROM orders o
    JOIN customers c ON c.customer_id = o.customer_id
) t
WHERE rn <= 2
ORDER BY customer_name, rn;               

--- Uloha 2

SELECT
    region,
    customer_name,
    total_profit,
    RANK() OVER (
        PARTITION BY region
        ORDER BY total_profit DESC
    ) AS rank_profit,
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY total_profit DESC
    ) AS dense_rank_profit
FROM (
    SELECT
        c.customer_id,
        c.region,
        c.customer_name,
        SUM(o.profit) AS total_profit
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.region, c.customer_name
) t
ORDER BY region, rank_profit, customer_name;

-- Uloha 3


SELECT
    customer_name,
    total_sales,
    NTILE(4) OVER (ORDER BY total_sales DESC) AS quartile
FROM (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(o.sales) AS total_sales
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.customer_name
) t
ORDER BY quartile, total_sales DESC;


