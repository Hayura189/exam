use classic_models
--1
select (first_name +' '+ last_name) from employees
where job_title like '%VP%' or job_title like '%Manager%'

--2
select country,count(customer_number) as [countofcus] from customers
group by country

--3
select top 1 product_lines.product_line, sum(products.quantity_in_stock) as [countofproduct] from products
join product_lines on products.product_line=product_lines.product_line
group by product_lines.product_line
order by countofproduct asc

--4
SELECT AVG((msrp - buy_price) / buy_price * 100) AS avg_price_percent
FROM products;

--5
select order_number, avg(quantity_ordered) as [averageofpro] from order_details
group by order_number

--6
select (select count(*) from orders where [status] like 'Cancelled')*1.0  / count(*)*1.0 *100  from orders

--7
select avg(DATEDIFF(DAY,order_date,shipped_date)) from orders
where [status] like 'Shipped'

--8 
select top 1 products.product_line,sum(order_details.quantity_ordered*order_details.price_each) as [profit] from order_details
join products on order_details.product_code=products.product_code
group by products.product_line
order by profit desc

--9
select top 1 year(payment_date) as [year],DATEPART(QUARTER,payment_date) as [quarter],sum(amount) as [total_profit] from payments
group by year(payment_date),DATEPART(QUARTER,payment_date)
order by total_profit desc

--10
select products.product_name from products
left join order_details on products.product_code=order_details.product_code
where order_details.product_code is null