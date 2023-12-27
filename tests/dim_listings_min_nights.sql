SELECT * FROM {{ ref("dim_listings_clean")}}
WHERE min_nights < 1