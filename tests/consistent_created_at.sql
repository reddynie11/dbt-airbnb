WITH reviews AS (
    SELECT * FROM {{ref("fct_reviews")}}
),
listings AS (
    SELECT * FROM {{ref("dim_listings_clean")}}
)
SELECT * FROM 
reviews r LEFT JOIN listings l ON r.listing_id = l.listing_id
WHERE r.review_date < l.created_at