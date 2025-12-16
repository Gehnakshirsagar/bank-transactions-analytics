INSERT INTO customers (full_name, dob, city)
VALUES
('Alice Vermeulen', '1998-04-12', 'Antwerp'),
('Jonas Peeters', '1995-09-30', 'Brussels'),
('Sophie Maes', '2000-01-18', 'Ghent'),
('Liam De Smet', '1992-06-05', 'Antwerp');

INSERT INTO accounts (customer_id, account_type, currency, status)
VALUES
(1, 'checking', 'EUR', 'active'),
(1, 'savings',  'EUR', 'active'),
(2, 'checking', 'EUR', 'active'),
(3, 'checking', 'EUR', 'active'),
(4, 'checking', 'EUR', 'blocked');
INSERT INTO categories (category_name)
VALUES
('Groceries'),
('Transport'),
('Restaurants'),
('Utilities'),
('Entertainment');

INSERT INTO merchants (merchant_name, category_id)
VALUES
('Carrefour', 1),
('Delhaize', 1),
('NMBS', 2),
('Uber', 2),
('Netflix', 5),
('McDonalds', 3),
('Engie', 4);

INSERT INTO transactions
(account_id, txn_ts, txn_type, amount, channel, status, merchant_id, description, balance_after)
VALUES
-- Alice (checking)
(1, '2024-01-05 10:15', 'debit', 45.60, 'card', 'posted', 1, 'Grocery shopping', 1454.40),
(1, '2024-01-10 08:30', 'debit', 12.20, 'card', 'posted', 3, 'Train ticket', 1442.20),
(1, '2024-02-01 18:45', 'debit', 65.00, 'card', 'posted', 6, 'Dinner', 1377.20),
(1, '2024-02-25 09:00', 'credit', 2000.00, 'online', 'posted', NULL, 'Salary', 3377.20),

-- Alice (savings)
(2, '2024-02-26 12:00', 'credit', 500.00, 'online', 'posted', NULL, 'Savings deposit', 500.00),

-- Jonas
(3, '2024-01-15 14:20', 'debit', 120.00, 'card', 'posted', 5, 'Streaming subscription', 880.00),
(3, '2024-02-03 20:10', 'debit', 32.50, 'card', 'posted', 6, 'Fast food', 847.50),
(3, '2024-02-18 11:00', 'credit', 1800.00, 'online', 'posted', NULL, 'Salary', 2647.50),

-- Sophie
(4, '2024-01-08 16:40', 'debit', 75.00, 'card', 'posted', 7, 'Electricity bill', 925.00),
(4, '2024-02-14 19:30', 'debit', 48.90, 'card', 'posted', 3, 'Train travel', 876.10),

-- Liam (blocked account)
(5, '2024-01-20 22:15', 'debit', 250.00, 'online', 'failed', 4, 'Late night ride', 1200.00);

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM accounts;
SELECT COUNT(*) FROM transactions;


