-- ===========================================
-- Q2: Monthly Revenue Trend
-- Objective:
-- Calculate total revenue for each month to
-- analyze sales trends over time.
-- ===========================================

select
    date_format(o.order_purchase_timestamp,'%Y-%m') as month_year,
    round(sum(op.payment_value),2) as revenue
from orders o
join order_payments op
    on o.order_id = op.order_id
group by month_year
order by month_year asc;
