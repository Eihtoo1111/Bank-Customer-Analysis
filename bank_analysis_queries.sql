-- ============================================================
-- Bank Customer Data Analysis — SQL Queries
-- Dataset: bank_customers + bank_transactions
-- ============================================================


-- ============================================================
-- QUERY 1: Customers with Highest Balance (Top 5)
-- ============================================================
SELECT
    customer_id,
    first_name || ' ' || last_name AS full_name,
    city,
    account_type,
    account_balance
FROM bank_customers
ORDER BY account_balance DESC
LIMIT 5;


-- ============================================================
-- QUERY 2: Monthly Transaction Totals
-- ============================================================
SELECT
    strftime('%Y-%m', transaction_date) AS month,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END), 2) AS total_credits,
    ROUND(SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END), 2) AS total_debits
FROM bank_transactions
GROUP BY month
ORDER BY month;


-- ============================================================
-- QUERY 3: Customers with Loans but Low Balance (< $10,000)
-- ============================================================
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    c.account_balance,
    c.loan_amount,
    c.loan_status
FROM bank_customers c
WHERE c.loan_status = 'Active'
  AND c.account_balance < 10000
ORDER BY c.account_balance ASC;


-- ============================================================
-- QUERY 4: Average Account Balance by Account Type
-- ============================================================
SELECT
    account_type,
    COUNT(*) AS num_customers,
    ROUND(AVG(account_balance), 2) AS avg_balance,
    ROUND(MIN(account_balance), 2) AS min_balance,
    ROUND(MAX(account_balance), 2) AS max_balance
FROM bank_customers
GROUP BY account_type;


-- ============================================================
-- QUERY 5: Fraud Detection — Large Suspicious Transactions
-- ============================================================
SELECT
    t.transaction_id,
    t.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    t.transaction_date,
    t.amount,
    t.merchant,
    t.category
FROM bank_transactions t
JOIN bank_customers c ON t.customer_id = c.customer_id
WHERE t.amount > 10000
  AND t.category = 'Suspicious'
ORDER BY t.amount DESC;
