-- ===========================================
-- Q6: Customer Spend Segmentation
-- Objective:
-- Classify customers into Low, Medium, and High
-- spending groups based on total purchase value.
-- ===========================================

with customer_spending as (
    select
        c.customer_unique_id,
        round(sum(op.payment_value),2) as customer_spent
    from order_payments op
    join orders o on o.order_id = op.order_id
    join customers c on c.customer_id = o.customer_id
    group by c.customer_unique_id
)
select
    customer_unique_id,
    customer_spent,
        case
            when customer_spent < 300 then 'Low Spend'
            when customer_spent between 300 and 800 then 'Medium Spend'
            else 'High Spend'
        end as spend_category
from customer_spending
order by customer_spent desc;
