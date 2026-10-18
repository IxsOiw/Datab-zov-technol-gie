-- Uloha 1 

SELECT
    customer_id,
    invoice_no,
    invoice_date,
    quantity,
    unit_price,
    quantity * unit_price AS revenue,
    SUM(quantity * unit_price) OVER (
        PARTITION BY customer_id
        ORDER BY invoice_date
        RANGE BETWEEN INTERVAL '14 days' PRECEDING AND CURRENT ROW
    ) AS rolling_14d_revenue
FROM retail_sales  
limit 3;

-- Uloha 2

SELECT
    stock_code,
    country,
    invoice_date,
    quantity,
    AVG(quantity) OVER (
        PARTITION BY stock_code, country
        ORDER BY invoice_date
        RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW
    ) AS avg_quantity_7_days
FROM retail_sales
WHERE quantity > 1
ORDER BY stock_code, country, invoice_date;

-- Uloha 3

(
    SELECT
        customer_id,
        invoice_no,
        MIN(invoice_date) AS invoice_date
    FROM retail_sales
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id, invoice_no
),
orders_with_neighbors AS (
    SELECT
        customer_id,
        invoice_no,
        invoice_date,
        LAG(invoice_date) OVER w  AS previous_invoice_date,
        LEAD(invoice_date) OVER w AS next_invoice_date
    FROM unique_orders
    WINDOW w AS (
        PARTITION BY customer_id
        ORDER BY invoice_date, invoice_no
    )
)
SELECT
    customer_id,
    invoice_no,
    invoice_date,
    next_invoice_date,
    next_invoice_date::date - invoice_date::date      AS days_to_next_invoice
FROM orders_with_neighbors
WHERE next_invoice_date IS NOT NULL
ORDER BY days_to_next_invoice DESC
limit 4;

-- Uloha 4

WITH product_prices AS (
    SELECT
        stock_code,
        invoice_no,
        MIN(invoice_date) AS invoice_date,
        MIN(unit_price)   AS unit_price
    FROM retail_sales
    GROUP BY stock_code, invoice_no
),
prices_with_previous AS (
    SELECT
        stock_code,
        invoice_no,
        invoice_date,
        unit_price AS current_price,
        LAG(unit_price) OVER (
            PARTITION BY stock_code
            ORDER BY invoice_date, invoice_no
        ) AS previous_price
    FROM product_prices
)
SELECT
    stock_code,
    invoice_no,
    invoice_date,
    previous_price,
    current_price,
    current_price - previous_price AS price_difference
FROM prices_with_previous
WHERE previous_price IS NOT NULL
  AND current_price <> previous_price
ORDER BY invoice_date ASC;

-- Uloha 5

WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(quantity * unit_price) AS total_amount
    FROM retail_sales
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_amount,
    NTILE(4) OVER (ORDER BY total_amount DESC) AS sales_quartile
FROM customer_sales
ORDER BY total_amount DESC;
