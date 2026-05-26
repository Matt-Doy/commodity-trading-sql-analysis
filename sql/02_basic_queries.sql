-- 02_basic_queries.sql
-- Basic SQL queries for commodity trading analysis.

-- 1. Preview all trades
SELECT *
FROM trades
LIMIT 10;

-- 2. Total traded volume by commodity
SELECT
    commodity,
    SUM(volume_tons) AS total_volume_tons
FROM trades
GROUP BY commodity
ORDER BY total_volume_tons DESC;

-- 3. Average trade price by commodity
SELECT
    commodity,
    ROUND(AVG(price_usd_per_ton), 2) AS average_price_usd_per_ton
FROM trades
GROUP BY commodity
ORDER BY average_price_usd_per_ton DESC;

-- 4. Number of trades by Incoterm
SELECT
    incoterm,
    COUNT(*) AS number_of_trades
FROM trades
GROUP BY incoterm
ORDER BY number_of_trades DESC;

-- 5. Monthly traded volume by commodity
SELECT
    DATE_TRUNC('month', trade_date) AS trade_month,
    commodity,
    SUM(volume_tons) AS monthly_volume_tons
FROM trades
GROUP BY trade_month, commodity
ORDER BY trade_month, commodity;

-- 6. Largest trades by notional value
SELECT
    trade_id,
    trade_date,
    commodity,
    counterparty,
    volume_tons,
    price_usd_per_ton,
    volume_tons * price_usd_per_ton AS notional_value_usd
FROM trades
ORDER BY notional_value_usd DESC
LIMIT 10;
