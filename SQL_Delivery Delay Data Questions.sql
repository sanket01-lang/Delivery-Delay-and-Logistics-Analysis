select * from payments;
select * from products;
select * from sellers;
select * from order_items;
select * from orders;
alter table products
rename column `product category` to product_category;

select * from product_delivery_summary limit 5;

-- Q1) How many orders are delivered late and how many order are shipped late
select 
	count(*) as total_late_deliver_orders 
from product_delivery_summary 
where order_delivered_late is true;

-- where orders shipped late
select 
	count(*) as late_order_shipped 
from product_delivery_summary 
where is_late_shipping is true;



-- Q2 )select top 5 category where order deliver late and shipped late
select 
	product_category, 
    count(*) as late_order_delivered
from product_delivery_summary 
where order_delivered_late is true 
group by product_category 
order by late_order_delivered desc limit 5;

-- where shipped late
select 
product_category,
count(*) as late_shipped
from product_delivery_summary
where is_late_shipping is true
group by product_category
order by late_shipped desc limit 5;

-- Q3) find top 10 seller who delivered proudct late and shipped late
select 
	seller_id, 
    count(*) as times_late
from product_delivery_summary
where order_delivered_late is true
group by seller_id
order by times_late desc limit 10;

-- where shipped late

select 
	seller_id, 
    count(*) as times_late
from product_delivery_summary
where is_late_shipping is true
group by seller_id
order by times_late desc limit 10;

-- Q4) find top 5 seller and number of sellers who both delivered and shipped late
select 
	seller_id,
    count(*) as late_shipped_delivered
from product_delivery_summary
where order_delivered_late is true
and is_late_shipping is true
group by seller_id
order by late_shipped_delivered desc limit 5;

-- Q5) find top 5 product_category where shipped and delivered late
select
	product_category,
	count(*) as late_shipped_delivered
from product_delivery_summary
where is_late_shipping is true
and order_delivered_late is true
group by product_category
order by late_shipped_delivered desc limit 5;

-- Q6) find top 3 maximum number of days for order_handing (from seller to shipping)in each category

with order_hand_days as (
	select 
		product_category,
		order_handling_days,
		rank() over(partition by product_category order by order_handling_days desc) as rank_order,
		max(order_handling_days)  over(partition by product_category) as max_hand_days
    from product_delivery_summary
)
    select 
        product_category, 
		order_handling_days, 
		rank_order 
    from order_hand_days
    where rank_order <=3
	order by max_hand_days desc, product_category, order_handling_days desc; 
    
-- Q7) find top  3 most time take to order approved for each category with seller_id
with days_approved as (
select 
	product_category, 
	seller_id,
    order_approved_days,
    rank() over(partition by product_category order by order_approved_days desc) as rank_order,
    max(order_approved_days) over(partition by product_category) as total_order_approved_days
    from product_delivery_summary)
    
select 
	product_category,
    seller_id,
    order_approved_days,
   
    rank_order
from days_approved
where rank_order <= 3
order by total_order_approved_days desc, product_category, order_approved_days desc;
   
   
-- Q8) find relation between product_weight_g and order_delivered_days_to_customers
select
	avg(order_handling_days) as avg_handling_days,
	avg(order_delivered_customer_days) as avg_delivery_days,
		case 
			when product_weight_g <= 1000 then "light_weight(0-1000)"
			when product_weight_g <= 2000 then "standard_weight(1000-2000)"
			when product_weight_g <= 3000 then "heavy_weight(2000-3000)"
            else "very_heavy_weight"
		end as weight_category
        from product_delivery_summary
        group by weight_category
       order by avg_delivery_days, weight_category;
        


-- Q9) find top seller cities, states, order handling days are high
with handling_days as (select 
	seller_state, 
    seller_city,
    order_handling_days,
    rank() over(partition by seller_state order by order_handling_days desc) as rank_order,
    max(order_handling_days) over (partition by seller_state) as max_hand_days
from product_delivery_summary)
select seller_state, seller_city, order_handling_days , rank_order from handling_days where rank_order <=3 order by max_hand_days desc, seller_state, order_handling_days desc;

-- Q10) what is relation of payment type with order approvered
select 
	payment_type, 
    avg(order_approved_days) as avg_days 
from product_delivery_summary 
group by payment_type;

-- Q11) was large freight value make deleivery fast
select avg(order_delivered_customer_days) as avg_order_delivery_days,
		avg(product_weight_g) as avg_product_weight,
		case
			when total_freight_value <= 10 then "low_freight_value(0-10)"
            when total_freight_value <= 20 then "standard_freight_value(10-20)"
            when total_freight_value <=30 then "high_freight_value(20-30)"
            else "very_high_freight_value(30-40)"
            end as freight_value
            from product_delivery_summary
            group by freight_value
            order by avg_order_delivery_days ;
