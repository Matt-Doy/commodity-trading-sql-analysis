# Data Dictionary

## Important Note

All datasets are synthetic and created for educational purposes only. They do not represent real trades or real market prices.

## trades.csv

| Column | Description |
|---|---|
| trade_id | Unique fictional trade identifier |
| trade_date | Trade date |
| commodity | Commodity traded |
| counterparty | Fictional counterparty name |
| volume_tons | Trade volume in metric tons |
| price_usd_per_ton | Trade price in USD per metric ton |
| currency | Currency of the transaction |
| incoterm | Incoterm used for the trade |
| port_loading | Loading port |
| port_discharge | Discharge port |

## market_prices.csv

| Column | Description |
|---|---|
| price_date | Benchmark price date |
| commodity | Commodity benchmark |
| benchmark_price_usd_per_ton | Synthetic benchmark price in USD per metric ton |
| source | Source label, synthetic in this project |

## freight_costs.csv

| Column | Description |
|---|---|
| route_id | Fictional route identifier |
| port_loading | Loading port |
| port_discharge | Discharge port |
| freight_rate_usd_per_ton | Synthetic freight rate in USD per metric ton |

## counterparties.csv

| Column | Description |
|---|---|
| counterparty | Fictional counterparty name |
| country | Fictional counterparty country |
| rating | Simplified fictional credit rating |
| sector | Simplified business sector |
