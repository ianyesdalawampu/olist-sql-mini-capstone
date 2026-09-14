-- ===========================================
-- Q5: Top 3 Products Within Each Category
-- Objective:
-- Rank products by revenue within each product
-- category and return the top three products.
-- ===========================================

with product_revenue as (
    select
    p.product_category_name,
    oi.product_id,
    round(sum(op.payment_value),2) as total_revenue
    from products p
    join order_items oi
        on p.product_id = oi.product_id
    join order_payments op
        on op.order_id = oi.order_id
    group by p.product_category_name, oi.product_id
),
    ranked_products as(
    select
        product_category_name,
        product_id,
        total_revenue,
        row_number() over (
                            partition by product_category_name
                            order by total_revenue desc
                            ) as ranking
    from product_revenue

)

select
    product_category_name,
    ranking,
    product_id,
    total_revenue
from ranked_products
where ranking <= 3
order by product_category_name, ranking;
