use classic_models
--1
go
create function sum_product(@product_code nvarchar(10) )
returns int as BEGIN
DECLARE @result int
select @result=sum(order_details.quantity_ordered) from order_details
join products on order_details.product_code=products.product_code
where products.product_code=@product_code
group by products.product_code
return @result
END
go

--2
GO
create function sum_product_month (@order_month int,@order_year int  ) returns int as BEGIN
declare @result INT
select @result=sum(price_each*quantity_ordered) from order_details
join orders on order_details.order_number=orders.order_number
where year(orders.order_date)=@order_year and month(orders.order_date)=@order_month
return @result
END
go

--3
select offices.country,count(employee_number) as [number_employ] from employees
join offices on employees.office_code=offices.office_code
group by offices.country

--4
SELECT employees.employee_number, 
    SUM(order_details.price_each * order_details.quantity_ordered * 0.05) AS total_commission
FROM orders
JOIN customers ON orders.customer_number = customers.customer_number
JOIN order_details ON order_details.order_number = orders.order_number
JOIN employees ON employees.employee_number = customers.sales_rep_employee_number
WHERE employees.job_title = 'Sales Rep' AND orders.status = 'Shipped'
GROUP BY employees.employee_number;

--5
SELECT MONTH(payment_date) AS [month],
    SUM(IIF(YEAR(payment_date) = 2003, amount, 0)) AS total_2003,
    SUM(IIF(YEAR(payment_date) = 2004, amount, 0)) AS total_2004,
    SUM(IIF(YEAR(payment_date) = 2004, amount, 0)) - 
    SUM(IIF(YEAR(payment_date) = 2003, amount, 0)) AS amount_difference
FROM payments
WHERE YEAR(payment_date) IN (2003, 2004)
GROUP BY MONTH(payment_date)
ORDER BY [month];

--6
SELECT customers.customer_number,
    SUM(payments.amount) * 1.0 / SUM(order_details.price_each * order_details.quantity_ordered) AS ratio
FROM customers
JOIN payments ON payments.customer_number = customers.customer_number
JOIN orders ON orders.customer_number = customers.customer_number
JOIN order_details ON order_details.order_number = orders.order_number
GROUP BY customers.customer_number;

--7
SELECT YEAR(orders.order_Date) AS [year], MONTH(orders.order_Date) AS [month],
    (SUM(payments.amount) / SUM(order_details.quantity_Ordered * order_details.price_Each)) * 100 AS [percentage]
FROM orders
JOIN payments ON orders.customer_Number = payments.customer_Number
JOIN order_details ON orders.order_Number = order_details.order_Number
GROUP BY YEAR(orders.order_Date), MONTH(orders.order_Date)
ORDER BY [year], [month];

--8
SELECT top 2 p1.product_Name AS product1, p2.product_Name AS product2, COUNT(*) AS count
FROM order_details o1
JOIN order_details o2 ON o1.order_Number = o2.order_Number AND o1.product_Code < o2.product_Code
JOIN products p1 ON o1.product_Code = p1.product_Code
JOIN products p2 ON o2.product_Code = p2.product_Code
GROUP BY p1.product_Name, p2.product_Name
ORDER BY count DESC



