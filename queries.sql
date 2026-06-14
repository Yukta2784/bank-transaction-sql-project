CREATE TABLE transactions (
  transaction_id INT,
  customer_id VARCHAR(10),
  customer_name VARCHAR(50),
  city VARCHAR(30),
  branch VARCHAR(50),
  transaction_date DATE,
  transaction_type VARCHAR(10),
  amount INT,
  balance_after INT
);

/* QUERY TO SEE THE TABLE */
SELECT * FROM transactions;

/* QUERY TO FIND TOP 5 CUSTOMERS HAVING HIGHEST BALANCE AFTER*/
SELECT * FROM transactions ORDER BY balance_after DESC limit 5;

/*QUERY TO FIND monthly trends*/
SELECT 
    MONTH(transaction_date) as month_number,
    COUNT(*) as total_transactions,
    SUM(amount) as total_amount
FROM transactions
GROUP BY MONTH(transaction_date)
ORDER BY month_number;

/* query to find monthly trends per customer */
select customer_name, MONTH(transaction_date) as month_number,  COUNT(*) as total_transactions
from transactions group by customer_name, Month(transaction_date) order by month_number;

/* FRAUD DETECTION */
select customer_name, customer_id, amount from transactions where amount>= 50000;

/* RISK LEVEL */
SELECT customer_name, SUM(AMOUNT) as total_amount,
CASE 
WHEN SUM(AMOUNT)>200000 THEN 'HIGH RISK'
WHEN SUM(AMOUNT) BETWEEN 100000 AND 200000 THEN 'MEDIUM RISK'
ELSE 'LOW RISK'
END AS risk_level
from transactions
group by customer_name ;

/* BRANCH WISE TRANSACTIONS*/
select branch, COUNT(*) as total_transactions, SUM(AMOUNT) as total_amount from transactions group by branch;

/* Total amount credited and debited*/
SELECT transaction_type, count(*) as total_transactions, sum(amount) as total_amount from transactions group by transaction_type; 

/*transaction amount city wise*/
select city, sum(amount) as total_amount, count(*) as total_transactions from transactions group by city;

/* Highest single transaction per customer */
SELECT customer_name,
       SUM(amount) AS total_amount,
       MAX(amount) AS max_transaction
FROM transactions
GROUP BY customer_name;

/* customers who appeared for 3 times*/
SELECT customer_name from transactions GROUP BY customer_name
HAVING COUNT(*) = 3;

/* Average transaction amount per branch */
select branch, AVG(amount) from transactions group by branch;
