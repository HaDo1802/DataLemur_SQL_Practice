WITH order_counts AS (
  SELECT COUNT(order_id) AS total_orders 
  FROM orders
)

SELECT
  order_id,
  CASE
    WHEN order_id % 2 != 0 AND order_id != total_orders THEN order_id + 1 -- if the order_id is odd, it should be incremented by 1
    WHEN order_id % 2 != 0 AND order_id = total_orders THEN order_id -- fit the requirement for the last odd order
    ELSE order_id - 1 -- if the order_id is even, it should be decremented by 1
  END AS corrected_order_id,
  item
FROM orders
CROSS JOIN order_counts;
