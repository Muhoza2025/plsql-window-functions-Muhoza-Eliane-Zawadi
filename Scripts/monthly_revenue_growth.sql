-- Month-over-month revenue growth (%)
-- Category: Navigation (LAG)
WITH monthly_totals AS (
    SELECT
        sale_month,
        SUM(revenue) AS total_revenue
    FROM sales_summary
    GROUP BY sale_month
)
SELECT
    sale_month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY sale_month) AS prev_month_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY sale_month))
        / NULLIF(LAG(total_revenue) OVER (ORDER BY sale_month), 0) * 100,
        2
    ) AS mom_growth_percent
FROM monthly_totals
ORDER BY sale_month;