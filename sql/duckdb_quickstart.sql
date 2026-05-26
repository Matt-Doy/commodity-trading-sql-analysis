-- Optional DuckDB quickstart
-- DuckDB can query CSV files directly without importing them into a database.
-- Install DuckDB or use its Python package, then run queries like these.

SELECT *
FROM read_csv_auto('data/trades.csv')
LIMIT 10;

SELECT
    commodity,
    SUM(volume_tons) AS total_volume_tons
FROM read_csv_auto('data/trades.csv')
GROUP BY commodity
ORDER BY total_volume_tons DESC;

SELECT
    t.trade_id,
    t.trade_date,
    t.commodity,
    t.price_usd_per_ton,
    m.benchmark_price_usd_per_ton,
    ROUND(t.price_usd_per_ton - m.benchmark_price_usd_per_ton, 2) AS price_diff_usd_per_ton
FROM read_csv_auto('data/trades.csv') t
JOIN read_csv_auto('data/market_prices.csv') m
    ON t.trade_date = m.price_date
    AND t.commodity = m.commodity
ORDER BY ABS(t.price_usd_per_ton - m.benchmark_price_usd_per_ton) DESC
LIMIT 20;
