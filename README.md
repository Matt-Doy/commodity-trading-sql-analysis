# Commodity Trading — SQL Analysis

> **SQL · SQLite · pandas · Python**  
> Trade data querying · P&L analysis · Position tracking · Counterparty exposure · Market flows  
> *Applied SQL for commodity trading operations, middle office and risk management*

---

## Overview

This project demonstrates **SQL-based analysis of commodity trade data**, covering
the types of queries used daily in trading operations, middle office and risk management:
position monitoring, P&L attribution, counterparty exposure, trade flow analysis and
performance reporting.

The dataset simulates a commodity trading book (crude oil, refined products, agricultural)
with trades, counterparties, pricing and settlement data.

Built as a portfolio project for roles in **trading operations, trade support, risk analysis,
data analytics and back/middle office** at commodity trading houses.

---

## Why SQL Matters in Commodity Trading

In a trading house, SQL is used every day:

- **Operators** query CTRM systems to check open positions and pending deliveries
- **Risk managers** pull exposure reports by counterparty, commodity and tenor
- **Analysts** extract P&L attribution data for daily reporting
- **Finance teams** reconcile trade capture against settlement and invoicing

This project shows the practical SQL skills that support those workflows.

---

## Key Queries Included

| Query | Business Purpose |
|---|---|
| Open position by commodity | What is our current long/short exposure? |
| Daily P&L by trade | Which trades drove today's result? |
| Counterparty exposure | Who do we have the most credit risk with? |
| Trade flow by region | Where are our physical flows concentrated? |
| Settlement status | Which trades are pending confirmation or payment? |
| Volume by trader | How is the book split across the desk? |
| Price vs market mark | Are our trades at or above/below market? |
| Monthly P&L summary | Performance attribution by commodity and month |

---

## Dataset Structure

```sql
trades          -- trade_id, date, commodity, direction, volume, price, counterparty, status
counterparties  -- counterparty_id, name, country, credit_limit, credit_rating
prices          -- date, commodity, market_price, source
settlements     -- trade_id, settlement_date, amount, currency, status
positions       -- commodity, net_volume, avg_price, unrealised_pnl
```

---

## Sample Query

```sql
-- Daily P&L by commodity: mark-to-market vs traded price
SELECT
    t.commodity,
    SUM(t.volume * (p.market_price - t.price)) AS unrealised_pnl,
    COUNT(t.trade_id)                           AS num_trades,
    SUM(t.volume)                               AS total_volume
FROM trades t
JOIN prices p
    ON t.commodity = p.commodity
    AND p.date = CURRENT_DATE
WHERE t.status = 'open'
GROUP BY t.commodity
ORDER BY unrealised_pnl DESC;
```

---

## Repository Structure

```
commodity-trading-sql-analysis/
│
├── sql/
│   ├── 01_positions.sql          ← open position queries
│   ├── 02_pnl_analysis.sql       ← P&L attribution
│   ├── 03_counterparty.sql       ← exposure by counterparty
│   ├── 04_flows.sql              ← trade flow analysis
│   └── 05_settlement.sql         ← settlement and invoicing
│
├── data/
│   └── sample_trading_data.db    ← SQLite database with sample data
│
├── notebooks/
│   └── sql_analysis.ipynb        ← interactive walkthrough with pandas
│
├── README.md
└── requirements.txt
```

---

## Quickstart

```bash
git clone https://github.com/Matt-Doy/commodity-trading-sql-analysis.git
cd commodity-trading-sql-analysis

# Run queries directly on the SQLite database
sqlite3 data/sample_trading_data.db < sql/01_positions.sql

# Or use the interactive notebook
pip install -r requirements.txt
jupyter notebook notebooks/sql_analysis.ipynb
```

---

## Tools

`SQL` `SQLite` `Python` `pandas` `Jupyter Notebook`

---

## Related Projects

→ [brent-wti-market-analysis](https://github.com/Matt-Doy/brent-wti-market-analysis) — crude oil price dynamics  
→ [shipping-voyage-estimate-tool](https://github.com/Matt-Doy/shipping-voyage-estimate-tool) — voyage P&L and TCE  
→ [brazilian-soybean-export-dashboard](https://github.com/Matt-Doy/brazilian-soybean-export-dashboard) — commodity flow dashboard

---

## About

Built by **Mattéo Doyen** — Shipping & Trading Graduate (M2, IAE Nantes, 2026).  
[LinkedIn](https://www.linkedin.com/in/mattéo-doyen/) · [GitHub](https://github.com/Matt-Doy)
