-- 04_window_functions.sql
-- Window functions for ranking and time-based analysis.

-- 1. Rank counterparties by traded volume within each commodity
SELECT
    commodity,
    counterparty,
    SUM(volume_tons) AS total_volume_tons,
    RANK() OVER (
        PARTITION BY commodity
        ORDER BY SUM(volume_tons) DESC
    ) AS volume_rank
FROM trades
GROUP BY commodity, counterparty
ORDER BY commodity, volume_rank;

-- 2. Rank trades by notional value
SELECT
    trade_id,
    trade_date,
    commodity,
    counterparty,
    volume_tons,
    price_usd_per_ton,
    volume_tons * price_usd_per_ton AS notional_value_usd,
    RANK() OVER (
        ORDER BY volume_tons * price_usd_per_ton DESC
    ) AS notional_rank
FROM trades;

-- 3. Month-on-month volume change by commodity
WITH monthly_volume AS (
    SELECT
        DATE_TRUNC('month', trade_date) AS trade_month,
        commodity,
        SUM(volume_tons) AS monthly_volume_tons
    FROM trades
    GROUP BY trade_month, commodity
)
SELECT
    trade_month,
    commodity,
    monthly_volume_tons,
    LAG(monthly_volume_tons) OVER (
        PARTITION BY commodity
        ORDER BY trade_month
    ) AS previous_month_volume,
    monthly_volume_tons - LAG(monthly_volume_tons) OVER (
        PARTITION BY commodity
        ORDER BY trade_month
    ) AS volume_change
FROM monthly_volume
ORDER BY commodity, trade_month;

-- 4. Top 3 trades per commodity by notional value
WITH ranked_trades AS (
    SELECT
        trade_id,
        trade_date,
        commodity,
        counterparty,
        volume_tons,
        price_usd_per_ton,
        volume_tons * price_usd_per_ton AS notional_value_usd,
        ROW_NUMBER() OVER (
            PARTITION BY commodity
            ORDER BY volume_tons * price_usd_per_ton DESC
        ) AS row_num
    FROM trades
)
SELECT *
FROM ranked_trades
WHERE row_num <= 3
ORDER BY commodity, row_num;
