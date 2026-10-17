WITH
    source AS (
        SELECT * FROM {{ source('stripe', 'payment') }}
    )

    ,renamed AS (
        SELECT
            id AS payment_id
            ,orderid AS order_id
            ,paymentmethod AS payment_method
            ,status AS payment_status
            ,CAST(amount AS NUMERIC) / 100 AS amount
            ,created AS created_at
            ,_batched_at
        FROM source
    )

SELECT * FROM renamed
