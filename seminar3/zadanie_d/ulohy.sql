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
