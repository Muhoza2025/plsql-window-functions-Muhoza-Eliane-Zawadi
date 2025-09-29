-- Top 5 products per region per quarter
-- Category: Ranking (RANK)
SELECT
    region,
    quarter,
    product_name,
    total_revenue,
    RANK() OVER (PARTITION BY region, quarter ORDER BY total_revenue DESC) AS product_rank
FROM (
    SELECT
        region,
        quarter,
        product_name,
        SUM(revenue) AS total_revenue
    FROM sales_summary
    GROUP BY region, quarter, product_name
) ranked
WHERE RANK() OVER (PARTITION BY region, quarter ORDER BY total_revenue DESC) <= 5
ORDER BY region, quarter, product_rank;