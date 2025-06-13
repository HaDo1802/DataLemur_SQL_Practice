WITH price_extremes AS (
    SELECT
        ticker,
        MAX(open) AS highest_open,
        MIN(open) AS lowest_open
    FROM stock_prices
    WHERE ticker IN ('AAPL', 'AMZN', 'FB', 'GOOG', 'NFLX','META','MSFT')
    GROUP BY ticker
),
with_months AS (
    SELECT
        sp.ticker,
        TO_CHAR(sp.date, 'Mon-YYYY') AS month_year,
        sp.open
    FROM stock_prices sp
    WHERE ticker IN ('AAPL', 'AMZN', 'FB', 'GOOG', 'NFLX','META','MSFT')
)
SELECT p.ticker,
  max(case when w.open = p.highest_open then month_year end) as highest_mth, --great techique
  p.highest_open,
  max(case when w.open = p.lowest_open then month_year end) as lowest_mth,
  p.lowest_open
FROM price_extremes p
JOIN with_months w ON p.ticker = w.ticker
group by p.ticker, 
p.highest_open,
p.lowest_open
ORDER BY p.ticker;