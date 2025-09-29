-- 3 month moving average of daily production volume
-- Category: Aggregate (AVG with custom frame)
WITH daily_volume AS (
    SELECT
        sale_date,
        SUM(quantity) AS daily_units
    FROM sales
    GROUP BY sale_date
),
monthly_avg AS (
    SELECT
        DATE_TRUNC('month', sale_date)::DATE AS month,
        AVG(daily_units) AS avg_daily_units
    FROM daily_volume
    GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT
    month,
    avg_daily_units,
    ROUND(
        AVG(avg_daily_units) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS three_month_moving_avg
FROM monthly_avg
ORDER BY month;