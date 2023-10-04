-- 1) show total revenue in year 2020 in Chennai
SELECT sum(profit_margin) as revenue
FROM sales.transactions
WHERE market_code = 'Mark001' 
      and order_date between '2020-01-01' AND '2020-12-31';

-- 2) show total revenue in year 2020, January Month
SELECT sum(profit_margin) as revenue FROM sales.transactions
WHERE order_date between '2020-01-01' AND '2020-01-31';


-- 3) show the most profitable markets_name and total sales_amount for them
SELECT custmer_name,sum(profit_margin) as profit, sum(sales_amount) as total_sales_amount 
FROM sales.transactions
INNER JOIN sales.customers ON sales.transactions.customer_code = sales.customers.customer_code
GROUP BY sales.transactions.customer_code
ORDER BY profit desc
LIMIT 1;

-- 4) show the customer who bought the most product Prod048
SELECT count(*) as count_transactions,product_code,customer_code
FROM sales.transactions
WHERE product_code = 'Prod048'
GROUP BY customer_code
ORDER BY count_transactions desc
LIMIT 1;


-- 5) show the average number of products sold per month
SELECT avg(sales_qty) as average_sold_per_month,YEAR(order_date) as order_year, MONTH(order_date) as order_month 
FROM sales.transactions
GROUP BY order_year,order_month
ORDER BY order_year,order_month;

-- 6)
SELECT count(*) as count_of_purchases,custmer_name
FROM sales.transactions
INNER JOIN sales.customers ON sales.transactions.customer_code = sales.customers.customer_code
WHERE sales.transactions.order_date between '2017-01-01' AND '2017-12-31'
GROUP BY sales.transactions.customer_code
ORDER BY count_of_purchases desc
LIMIT 10;