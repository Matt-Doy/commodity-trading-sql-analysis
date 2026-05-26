-- 01_create_tables.sql
-- PostgreSQL-style table creation script.
-- The CSV files in /data contain synthetic data created for educational purposes.

DROP TABLE IF EXISTS trades;
DROP TABLE IF EXISTS market_prices;
DROP TABLE IF EXISTS freight_costs;
DROP TABLE IF EXISTS counterparties;

CREATE TABLE trades (
    trade_id VARCHAR(20) PRIMARY KEY,
    trade_date DATE,
    commodity VARCHAR(50),
    counterparty VARCHAR(100),
    volume_tons NUMERIC,
    price_usd_per_ton NUMERIC,
    currency VARCHAR(10),
    incoterm VARCHAR(10),
    port_loading VARCHAR(100),
    port_discharge VARCHAR(100)
);

CREATE TABLE market_prices (
    price_date DATE,
    commodity VARCHAR(50),
    benchmark_price_usd_per_ton NUMERIC,
    source VARCHAR(100)
);

CREATE TABLE freight_costs (
    route_id VARCHAR(20) PRIMARY KEY,
    port_loading VARCHAR(100),
    port_discharge VARCHAR(100),
    freight_rate_usd_per_ton NUMERIC
);

CREATE TABLE counterparties (
    counterparty VARCHAR(100) PRIMARY KEY,
    country VARCHAR(100),
    rating VARCHAR(20),
    sector VARCHAR(100)
);

-- Example PostgreSQL import commands:
-- COPY trades FROM '/absolute/path/to/data/trades.csv' DELIMITER ',' CSV HEADER;
-- COPY market_prices FROM '/absolute/path/to/data/market_prices.csv' DELIMITER ',' CSV HEADER;
-- COPY freight_costs FROM '/absolute/path/to/data/freight_costs.csv' DELIMITER ',' CSV HEADER;
-- COPY counterparties FROM '/absolute/path/to/data/counterparties.csv' DELIMITER ',' CSV HEADER;
