-- 05_business_questions.sql
-- Business-oriented questions using SQL.

-- Q1. Which commodities generate the largest notional exposure?
SELECT
    commodity,
    SUM(volume_tons * price_usd_per_ton) AS total_notional_usd
FROM trades
GROUP BY commodity
ORDER BY total_notional_usd DESC;

-- Q2. Which counterparties represent the largest commercial exposure?
SELECT
    counterparty,
    SUM(volume_tons * price_usd_per_ton) AS total_exposure_usd,
    COUNT(*) AS number_of_trades
FROM trades
GROUP BY counterparty
ORDER BY total_exposure_usd DESC;

-- Q3. Which routes have the highest average freight cost?
SELECT
    port_loading,
    port_discharge,
    AVG(freight_rate_usd_per_ton) AS avg_freight_rate_usd_per_ton
FROM freight_costs
GROUP BY port_loading, port_discharge
ORDER BY avg_freight_rate_usd_per_ton DESC;

-- Q4. Which trades are priced most above benchmark?
SELECT
    t.trade_id,
    t.trade_date,
    t.commodity,
    t.counterparty,
    t.price_usd_per_ton,
    m.benchmark_price_usd_per_ton,
    ROUND(t.price_usd_per_ton - m.benchmark_price_usd_per_ton, 2) AS premium_to_benchmark
FROM trades t
JOIN market_prices m
    ON t.trade_date = m.price_date
    AND t.commodity = m.commodity
WHERE t.price_usd_per_ton > m.benchmark_price_usd_per_ton
ORDER BY premium_to_benchmark DESC;

-- Q5. Which trades have a negative freight-adjusted margin proxy?
SELECT
    t.trade_id,
    t.trade_date,
    t.commodity,
    t.counterparty,
    t.port_loading,
    t.port_discharge,
    ROUND((t.price_usd_per_ton - m.benchmark_price_usd_per_ton - f.freight_rate_usd_per_ton), 2) AS margin_proxy_usd_per_ton
FROM trades t
JOIN market_prices m
    ON t.trade_date = m.price_date
    AND t.commodity = m.commodity
JOIN freight_costs f
    ON t.port_loading = f.port_loading
    AND t.port_discharge = f.port_discharge
WHERE (t.price_usd_per_ton - m.benchmark_price_usd_per_ton - f.freight_rate_usd_per_ton) < 0
ORDER BY margin_proxy_usd_per_ton ASC;
