# Bank Transactions Analytics (PostgreSQL + SQL)

## Overview
This project simulates a small banking analytics environment and demonstrates
how SQL can be used to analyze customer transactions, spending behavior,
and potential risk indicators such as failed or reversed transactions.

The project focuses on practical SQL skills used in real data analyst work,
including database design, data loading, analytical querying, and insight
generation.

## Tools & Technologies
- PostgreSQL
- pgAdmin 4
- SQL

## Dataset
The dataset used in this project is a realistic sample dataset created for
learning and analysis purposes. It includes customers, bank accounts,
merchants, spending categories, and transaction records across multiple
channels.

## Database Design

### Tables
- **customers** – customer demographic information  
- **accounts** – bank accounts linked to customers  
- **categories** – merchant spending categories  
- **merchants** – merchant information linked to categories  
- **transactions** – debit, credit, and transfer transaction records  

### Design Considerations
- Foreign keys enforce relational integrity
- CHECK constraints validate transaction types, statuses, and amounts
- VARCHAR and CHAR data types are used instead of TEXT to simulate
  production-style schemas
- Indexes are added to optimize analytical query performance

## Business Questions & Analysis

### Spending Trends Over Time
- How does customer spending change month-to-month?
- Are there specific months with higher transaction activity?

### Channel Behavior
- How does transaction behavior differ by channel (card, online, ATM, branch)?
- What is the average transaction value per channel?

### Risk & Exception Monitoring
- Which accounts have failed or reversed transactions?
- Are failed transactions concentrated in blocked accounts?

## Example SQL Queries
```sql
### Total Spending per Customer (Posted Debits)
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

Monthly Spending Trend
SELECT
  DATE_TRUNC('month', txn_ts) AS month,
  SUM(amount) AS total_spent
FROM transactions
WHERE txn_type = 'debit'
  AND status = 'posted'
GROUP BY month
ORDER BY month;

Average Transaction Value by Channel
SELECT
  channel,
  ROUND(AVG(amount), 2) AS avg_transaction_value
FROM transactions
WHERE status = 'posted'
GROUP BY channel
ORDER BY avg_transaction_value DESC;

Failed or Reversed Transactions by Account (with Customer Context)
SELECT
  c.full_name,
  a.account_id,
  a.status AS account_status,
  COUNT(*) AS failed_transactions
FROM transactions t
JOIN accounts a ON a.account_id = t.account_id
JOIN customers c ON c.customer_id = a.customer_id
WHERE t.status IN ('failed','reversed')
GROUP BY c.full_name, a.account_id, a.status
ORDER BY failed_transactions DESC;
