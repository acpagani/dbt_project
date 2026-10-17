WITH
    source AS (
        SELECT * FROM {{ source('jaffle_shop', 'orders') }}
    )

    ,renamed AS (
        SELECT
            id AS order_id
            ,user_id AS customer_id
            ,order_date
            ,status AS order_status
            ,_etl_loaded_at
        FROM source
    )

SELECT * FROM renamed