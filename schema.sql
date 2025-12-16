CREATE TABLE customers (
  customer_id  SERIAL PRIMARY KEY,
  full_name    VARCHAR(100) NOT NULL,
  dob          DATE NOT NULL,
  city         VARCHAR(50),
  created_at   TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE accounts (
  account_id   SERIAL PRIMARY KEY,
  customer_id  INT NOT NULL REFERENCES customers(customer_id),
  account_type VARCHAR(20) NOT NULL CHECK (account_type IN ('checking','savings')),
  currency     CHAR(3) NOT NULL DEFAULT 'EUR',
  status       VARCHAR(20) NOT NULL CHECK (status IN ('active','blocked','closed')),
  opened_at    TIMESTAMP NOT NULL DEFAULT NOW()
);
CREATE TABLE categories (
  category_id   SERIAL PRIMARY KEY,
  category_name VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE merchants (
  merchant_id   SERIAL PRIMARY KEY,
  merchant_name VARCHAR(100) NOT NULL,
  category_id   INT NOT NULL REFERENCES categories(category_id)
);
CREATE TABLE transactions (
  txn_id                  BIGSERIAL PRIMARY KEY,
  account_id              INT NOT NULL REFERENCES accounts(account_id),
  txn_ts                  TIMESTAMP NOT NULL,
  txn_type                VARCHAR(20) NOT NULL CHECK (txn_type IN ('debit','credit','transfer')),
  amount                  NUMERIC(12,2) NOT NULL CHECK (amount > 0),
  channel                 VARCHAR(20) NOT NULL CHECK (channel IN ('card','atm','online','branch')),
  status                  VARCHAR(20) NOT NULL CHECK (status IN ('posted','pending','reversed','failed')),
  merchant_id             INT REFERENCES merchants(merchant_id),
  counterparty_account_id INT REFERENCES accounts(account_id),
  description             VARCHAR(255),
  balance_after           NUMERIC(14,2)
);

CREATE INDEX idx_txn_account_ts ON transactions(account_id, txn_ts);
CREATE INDEX idx_txn_merchant ON transactions(merchant_id);
CREATE INDEX idx_txn_type ON transactions(txn_type);
