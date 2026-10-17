WITH
    orders AS (
        SELECT
            order_id
            ,customer_id
            ,order_date
            ,order_status
        FROM {{ ref('stg_jaffle_shop__orders') }}
    )

    ,payments AS (
        SELECT
            payment_id
            ,order_id
            ,payment_status
            ,amount
        FROM {{ ref('stg_stripe__payments') }}
        WHERE payment_status = 'success'
    )

SELECT
    t1.order_id
    ,t1.customer_id
    ,t1.order_date
    ,t1.order_status
    ,SUM(t2.amount) AS amount
FROM orders AS t1
JOIN payments AS t2 ON t1.order_id = t2.order_id
GROUP BY 1,2,3,4