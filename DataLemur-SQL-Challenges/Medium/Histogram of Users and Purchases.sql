WITH latest_txn AS (
  SELECT user_id, MAX(transaction_date) AS max_txn_date
  FROM user_transactions
  GROUP BY user_id
)

SELECT 
  t.transaction_date,
  t.user_id,
  COUNT(*) AS purchase_count
FROM user_transactions t
JOIN latest_txn l
  ON t.user_id = l.user_id AND t.transaction_date = l.max_txn_date
GROUP BY t.user_id, t.transaction_date
ORDER BY t.transaction_date;
