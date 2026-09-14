-- ===========================================
-- Q7: Repeat Buyers vs One-Time Buyers
-- Objective:
-- Classify customers based on the number of orders
-- they placed and count repeat vs one-time buyers.
-- ===========================================

with customer_orders as (
    select
        c.customer_unique_id,
        count(o.order_id) as count_per_buyer
    from orders o
    join customers c on c.customer_id = o.customer_id
    group by c.customer_unique_id
    )
select
    case
        when count_per_buyer = 1 then 'One Time Buyer'
        else 'Repeat Buyer'
    end as customer_type,
    count(*) as total_customers
from customer_orders
group by customer_type;
