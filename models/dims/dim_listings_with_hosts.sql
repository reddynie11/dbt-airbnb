WITH l AS (
    SELECT
        listing_id,
        listing_name,
        room_type,
        CASE
            WHEN min_nights = 0 THEN 1
            ELSE min_nights
        END AS min_nights,
        host_id,
        REPLACE(price_str, '$')::NUMBER(10,2) AS price,
        created_at,
        updated_at
        FROM {{ ref("src_listing")}}
),
h AS (
    SELECT
        host_id,
        CASE 
            WHEN host_name IS NULL THEN 'Anonymous'
            ELSE host_name
        END AS host_name,
        is_superhost,
        created_at,
        updated_at FROM {{ ref("src_hosts")}}
)
SELECT 
l.listing_id,
l.listing_name,
l.room_type,
l.min_nights,
l.host_id,
h.host_name,
l.price,
h.is_superhost AS host_is_superhost,
l.created_at,
GREATEST(l.updated_at, h.updated_at) AS updated_at
FROM l LEFT JOIN h ON l.host_id = h.host_id