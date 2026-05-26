-- 03_joins_analysis.sql
-- Join-based analysis for benchmark comparison, freight costs and counterparty exposure.

-- 1. Compare trade prices with benchmark prices
SELECT
    t.trade_id,
    t.trade_date,
    t.commodity,
    t.counterparty,
    t.price_usd_per_ton,
    m.benchmark_price_usd_per_ton,
    ROUND(t.price_usd_per_ton - m.benchmark_price_usd_per_ton, 2) AS price_diff_usd_per_ton
FROM trades t
JOIN market_prices m
    ON t.trade_date = m.price_date
    AND t.commodity = m.commodity
ORDER BY ABS(t.price_usd_per_ton - m.benchmark_price_usd_per_ton) DESC;

-- 2. Add freight costs to each trade
SELECT
    t.trade_id,
    t.commodity,
    t.port_loading,
    t.port_discharge,
    t.price_usd_per_ton,
    f.freight_rate_usd_per_ton,
    ROUND(t.price_usd_per_ton - f.freight_rate_usd_per_ton, 2) AS freight_adjusted_price
FROM trades t
JOIN freight_costs f
    ON t.port_loading = f.port_loading
    AND t.port_discharge = f.port_discharge;

-- 3. Counterparty exposure by country and rating
SELECT
    c.country,
    c.rating,
    SUM(t.volume_tons * t.price_usd_per_ton) AS exposure_usd
FROM trades t
JOIN counterparties c
    ON t.counterparty = c.counterparty
GROUP BY c.country, c.rating
ORDER BY exposure_usd DESC;

-- 4. Average benchmark deviation by commodity
SELECT
    t.commodity,
    ROUND(AVG(t.price_usd_per_ton - m.benchmark_price_usd_per_ton), 2) AS avg_price_vs_benchmark
FROM trades t
JOIN market_prices m
    ON t.trade_date = m.price_date
    AND t.commodity = m.commodity
GROUP BY t.commodity
ORDER BY avg_price_vs_benchmark DESC;

-- 5. Freight-adjusted margin proxy
SELECT
    t.trade_id,
    t.trade_date,
    t.commodity,
    t.counterparty,
    t.volume_tons,
    t.price_usd_per_ton,
    m.benchmark_price_usd_per_ton,
    f.freight_rate_usd_per_ton,
    ROUND((t.price_usd_per_ton - m.benchmark_price_usd_per_ton - f.freight_rate_usd_per_ton), 2) AS margin_proxy_usd_per_ton,
    ROUND((t.price_usd_per_ton - m.benchmark_price_usd_per_ton - f.freight_rate_usd_per_ton) * t.volume_tons, 2) AS margin_proxy_usd
FROM trades t
JOIN market_prices m
    ON t.trade_date = m.price_date
    AND t.commodity = m.commodity
JOIN freight_costs f
    ON t.port_loading = f.port_loading
    AND t.port_discharge = f.port_discharge
ORDER BY margin_proxy_usd DESC;
