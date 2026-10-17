WITH
    customers AS (
        SELECT
            customer_id
            ,first_name
            ,last_name
        FROM {{ ref('stg_jaffle_shop__customers') }}
    )

    ,fct AS (
        SELECT
            order_id
            ,customer_id
            ,order_date
            ,order_status
            ,amount
        FROM {{ ref('fct_orders') }}
    )

SELECT DISTINCT
    t1.customer_id
    ,t1.first_name
    ,t1.last_name
    ,COALESCE(MIN(t2.order_date), '0001-01-01') AS first_order_date
    ,COALESCE(MAX(t2.order_date), '0001-01-01') AS most_recent_order_date
    ,COUNT(t2.order_id) AS number_of_orders
    ,COALESCE(SUM(t2.amount), 0) AS lifetime_value
FROM customers AS t1
LEFT JOIN fct AS t2 ON t1.customer_id = t2.customer_id
GROUP BY 1,2,3