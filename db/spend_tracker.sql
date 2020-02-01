DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS tags;

CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  active boolean,
  logo VARCHAR(255)
);

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  label VARCHAR(255),
  active boolean,
  logo VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  tag_id INT REFERENCES tags(id),-- ON DELETE CASCADE,
  merchant_id INT REFERENCES merchants(id),-- ON DELETE CASCADE,
  amount FLOAT
);
