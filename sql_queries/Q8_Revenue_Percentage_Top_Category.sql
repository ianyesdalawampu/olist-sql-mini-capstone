-- ===========================================
-- Q8: Revenue Contribution by the Top Product Category
-- Objective:
-- Calculate top product category's percentage
-- contribution to the total revenue.
-- ===========================================

with revenue_category as (
    select
        p.product_category_name,
        round(sum(op.payment_value),2) as total_revenue
    from order_payments op
    join order_items oi on oi.order_id = op.order_id
    join products p on p.product_id = oi.product_id
    group by product_category_name
    )
select
    product_category_name,
    total_revenue,
    round(
            (total_revenue/sum(total_revenue)over())*100,2
    ) as revenue_percentage
from revenue_category
order by total_revenue desc
limit 1;
