-- Create sales summary view
CREATE OR REPLACE VIEW sales_summary AS
SELECT
    s.transaction_id,
    c.customer_id,
    c.name AS customer_name,
    c.region,
    p.product_id,
    p.name AS product_name,
    p.category,
    s.sale_date,
    s.quantity,
    s.unit_price,
    s.quantity * s.unit_price AS revenue,
    DATE_TRUNC('month', s.sale_date)::DATE AS sale_month,
    EXTRACT(QUARTER FROM s.sale_date) AS quarter
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id;