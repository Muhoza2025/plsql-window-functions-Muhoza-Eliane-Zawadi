-- Running monthly total revenue per category
-- Category: Aggregate (SUM with ROWS frame)
SELECT
    category,
    sale_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        PARTITION BY category
        ORDER BY sale_month
        ROWS UNBOUNDED PRECEDING
    ) AS running_total_revenue
FROM (
    SELECT
        category,
        sale_month,
        SUM(revenue) AS monthly_revenue
    FROM sales_summary
    GROUP BY category, sale_month
) monthly
ORDER BY category, sale_month;