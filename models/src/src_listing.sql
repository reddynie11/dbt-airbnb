WITH raw_listing_cte AS (
    SELECT * FROM {{ source('airbnb', 'listings')}}
)
SELECT
id AS listing_id,
name AS listing_name,
listing_url,
room_type,
host_id,
min_nights,
price AS price_str,
created_at,
updated_at
FROM raw_listing_cte