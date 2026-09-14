-- ===========================================
-- Q4: Revenue by Product Category
-- Objective:
-- Identify which product categories generate
-- the highest total revenue.
-- ===========================================

select
    p.product_category_name,
    round(sum(op.payment_value),2) as total_revenue
from order_payments op
join order_items oi 
    on oi.order_id = op.order_id
join products p 
    on p.product_id = oi.product_id
group by p.product_category_name
order by total_revenue desc;
