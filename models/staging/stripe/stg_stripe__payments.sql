WITH
    source AS (
        SELECT * FROM {{ source('stripe', 'payment') }}
    )

    ,renamed AS (
        SELECT
            id AS payment_id
            ,orderid AS order_id
            ,paymentmethod AS payment_method
            ,status
            ,amount / 100 AS amount
            ,created
            ,_batched_at
        FROM source
    )

SELECT * FROM renamed
