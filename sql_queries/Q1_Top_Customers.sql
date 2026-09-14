-- ===========================================
-- Q1: Top 10 Customers by Total Amount Spent
-- Objective:
-- Identify the customers with the highest total payment value.
-- ===========================================

with customer_spending as (
    select o.customer_id,
            sum(op.payment_value) as total_spent
    from orders o
    join order_payments op
        on o.order_id = op.order_id
    group by o.customer_id
    )

select c.customer_unique_id,
       cs.total_spent
from customers c
join customer_spending cs
    on c.customer_id = cs.customer_id
order by total_spent desc
limit 10;
