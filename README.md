# Commodity Trading SQL Analysis

## Overview

This project demonstrates how SQL can be used to analyze a simplified commodity trading dataset.

The objective is to simulate the type of queries that may be useful for trading, market analysis, risk, operations or middle-office teams: trade volumes, average prices, counterparty exposure, benchmark comparison, freight-adjusted margins and ranking analysis.

## Important note on the data

The dataset used in this project is **synthetic and created for educational purposes only**.  
It does not represent real trades, real counterparties, real market prices or confidential commercial information.

The goal is to demonstrate SQL logic and business reasoning in a commodity trading context.

## Business Context

Commodity trading teams often work with transactional data such as:

- trade date;
- commodity;
- counterparty;
- traded volume;
- trade price;
- benchmark price;
- loading and discharge ports;
- freight costs;
- Incoterms;
- exposure by counterparty or region.

SQL is widely used to extract, clean, aggregate and analyze this type of data from internal systems.

## Tools Used

- SQL
- PostgreSQL-style syntax
- CSV sample datasets

The queries can be adapted for SQLite, MySQL, SQL Server or BigQuery with minor syntax changes.

## Dataset Structure

The project uses four synthetic CSV tables:

### `trades.csv`

Contains fictional physical commodity trades.

Main columns:

- `trade_id`
- `trade_date`
- `commodity`
- `counterparty`
- `volume_tons`
- `price_usd_per_ton`
- `currency`
- `incoterm`
- `port_loading`
- `port_discharge`

### `market_prices.csv`

Contains fictional benchmark market prices.

Main columns:

- `price_date`
- `commodity`
- `benchmark_price_usd_per_ton`
- `source`

### `freight_costs.csv`

Contains simplified freight costs by route.

Main columns:

- `route_id`
- `port_loading`
- `port_discharge`
- `freight_rate_usd_per_ton`

### `counterparties.csv`

Contains fictional counterparty information.

Main columns:

- `counterparty`
- `country`
- `rating`
- `sector`

## Key SQL Skills Demonstrated

- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- aggregate functions: `SUM`, `AVG`, `COUNT`
- joins between trades, prices, freight and counterparties
- monthly aggregation
- benchmark comparison
- freight-adjusted margin analysis
- counterparty exposure analysis
- window functions: `RANK`, `ROW_NUMBER`, `LAG`
- common table expressions: `WITH`

## Project Structure

```text
commodity-trading-sql-analysis/
│
├── data/
│   ├── trades.csv
│   ├── market_prices.csv
│   ├── freight_costs.csv
│   └── counterparties.csv
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_basic_queries.sql
│   ├── 03_joins_analysis.sql
│   ├── 04_window_functions.sql
│   └── 05_business_questions.sql
│
├── outputs/
│   └── query_results_examples.md
│
├── docs/
│   └── data_dictionary.md
│
└── README.md
```

## Example Business Questions

This project answers questions such as:

1. Which commodities have the highest traded volume?
2. What is the average price by commodity?
3. Which counterparties represent the largest exposure?
4. How do trade prices compare with benchmark prices?
5. Which routes generate the highest freight-adjusted margin?
6. How does monthly traded volume evolve over time?
7. Which counterparty ranks first by volume for each commodity?

## Suggested Way to Use This Project

You can load the CSV files into a SQL database such as PostgreSQL, SQLite, DuckDB or BigQuery.

For a simple local test, DuckDB is very convenient because it can query CSV files directly.

Example:

```sql
SELECT *
FROM read_csv_auto('data/trades.csv')
LIMIT 5;
```

## Recruiter-Relevant Summary

This project shows practical SQL skills applied to a commodity trading context. It demonstrates the ability to structure trading data, join multiple datasets, calculate commercial indicators and extract business insights from transactional data.
