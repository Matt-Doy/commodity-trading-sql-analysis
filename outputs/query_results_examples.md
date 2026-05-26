# Query Results Examples

These are example interpretations of the SQL queries included in this project.

## Total traded volume by commodity

This query identifies which commodities account for the largest physical traded volume in the synthetic dataset.

Business interpretation:

- High volume commodities may require closer operational monitoring.
- Volume concentration by commodity can indicate exposure to specific market risks.

## Price vs benchmark comparison

This query compares each trade price with a synthetic benchmark price on the same date.

Business interpretation:

- A positive difference means the trade was priced above the benchmark.
- A negative difference means the trade was priced below the benchmark.
- This can be used as a simplified basis for price performance analysis.

## Counterparty exposure

This query aggregates notional exposure by counterparty.

Business interpretation:

- It helps identify concentration risk.
- A company may monitor whether too much exposure is concentrated with one counterparty or one country.

## Freight-adjusted margin proxy

This query subtracts benchmark price and freight cost from the trade price.

Business interpretation:

- This is not a full P&L calculation.
- It is a simplified commercial indicator to show how SQL can combine trading, benchmark and freight data.

## Window functions

The ranking queries show how to identify the largest counterparties or trades by commodity.

Business interpretation:

- Window functions are useful for ranking exposures within categories.
- This is common in trading, risk and operations reporting.
