Student ID:40735842-
13. One post code is responsible for more orders than any other. Show the customers from that post code, the number of orders they have each made and their average daily spend to the nearest penny?
SELECT
  a.post_code,
  u.first_name,
  u.last_name,
  COUNT(o.id) AS orders,
  ROUND(SUM(o.total_price) / DATEDIFF(MAX(o.order_date), MIN(o.order_date)), 2) AS average_daily_spend
FROM orders o
JOIN address a ON a.id = o.delivery_address_id
JOIN users u ON u.id = o.customer_id
WHERE a.post_code = (
  SELECT post_code
  FROM address
  GROUP BY post_code
  ORDER BY COUNT(*) DESC
  LIMIT 1
)
GROUP BY a.post_code, u.first_name, u.last_name
ORDER BY orders DESC;
