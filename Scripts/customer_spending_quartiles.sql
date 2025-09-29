-- Customer spending quartiles
-- Category: Distribution (NTILE)
SELECT
    customer_name,
    region,
    total_spend,
    NTILE(4) OVER (ORDER BY total_spend DESC) AS spend_quartile
FROM (
    SELECT
        customer_name,
        region,
        SUM(revenue) AS total_spend
    FROM sales_summary
    GROUP BY customer_name, region
) customer_totals
ORDER BY total_spend DESC;