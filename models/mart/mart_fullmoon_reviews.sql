{{
    config(
        materialized= 'table'
    )
}}

with fct_reviews as (
    SELECT * FROM {{ ref("fct_reviews") }}
),
fm_dates AS (
    SELECT * FROM {{ ref("seed_full_moon_dates") }}
)
SELECT
r.*,
CASE WHEN c.full_moon_date IS NULL THEN 'not full moon' ELSE 'full moon' END AS is_full_moon
FROM fct_reviews r
LEFT JOIN fm_dates c
ON TO_DATE(r.review_date) = DATEADD(DAY, 1, c.full_moon_date)