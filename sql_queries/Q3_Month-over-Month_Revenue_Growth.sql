-- ===========================================
-- Q3: Month-over-Month Revenue Growth
-- Objective:
-- Compare monthly revenue with the previous month
-- and calculate the month-over-month change.
-- ===========================================

with monthly_revenue as(
    select
        date_format(o.order_purchase_timestamp,'%Y-%m') as month_year,
        round(sum(op.payment_value),2) as revenue
    from orders o
    join order_payments op
        on o.order_id = op.order_id
    group by month_year
  ),
    revenue_with_previous as ( select
        month_year,
        revenue,
        lag(revenue,1) over(order by month_year) as previous_revenue
    from monthly_revenue )
select
    month_year,
    revenue,
    previous_revenue,
    round((revenue - previous_revenue),2) as change_revenue,
    round(((revenue - previous_revenue)/(nullif(previous_revenue,0)))*100,2) as revenue_growth_percentage
from revenue_with_previous
order by month_year asc;
