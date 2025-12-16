SELECT
  city,
  COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

SELECT
  account_type,
  COUNT(*) AS total_accounts
FROM accounts
GROUP BY account_type;

SELECT
  txn_type,
  COUNT(*) AS total_transactions
FROM transactions
GROUP BY txn_type;

SELECT
  txn_type,
  SUM(amount) AS total_amount
FROM transactions
GROUP BY txn_type;

SELECT
  c.full_name,
  SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
JOIN transactions t ON t.account_id = a.account_id
WHERE t.txn_type = 'debit'
  AND t.status = 'posted'
GROUP BY c.full_name
ORDER BY total_spent DESC;

SELECT
  cat.category_name,
  SUM(t.amount) AS total_spent
FROM transactions t
JOIN merchants m ON m.merchant_id = t.merchant_id
JOIN categories cat ON cat.category_id = m.category_id
WHERE t.txn_type = 'debit'
  AND t.status = 'posted'
GROUP BY cat.category_name
ORDER BY total_spent DESC;

SELECT
  DATE_TRUNC('month', txn_ts) AS month,
  SUM(amount) AS total_spent
FROM transactions
WHERE txn_type = 'debit'
  AND status = 'posted'
GROUP BY month
ORDER BY month;

SELECT
  channel,
  ROUND(AVG(amount), 2) AS avg_transaction_value
FROM transactions
WHERE status = 'posted'
GROUP BY channel;

SELECT
  a.account_id,
  COUNT(*) AS failed_transactions
FROM transactions t
JOIN accounts a ON a.account_id = t.account_id
WHERE t.status IN ('failed','reversed')
GROUP BY a.account_id
HAVING COUNT(*) > 1;

SELECT
  c.full_name,
  DATE_TRUNC('month', t.txn_ts) AS month,
  SUM(t.amount) AS monthly_spent,
  RANK() OVER (
    PARTITION BY DATE_TRUNC('month', t.txn_ts)
    ORDER BY SUM(t.amount) DESC
  ) AS spending_rank
FROM customers c
JOIN accounts a ON a.customer_id = c.customer_id
JOIN transactions t ON t.account_id = a.account_id
WHERE t.txn_type = 'debit'
  AND t.status = 'posted'
GROUP BY c.full_name, month
ORDER BY month, spending_rank;
