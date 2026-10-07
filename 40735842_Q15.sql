Student ID:40735842-
15.  If I order a delivery between 1830 and 1930 on a Friday, what is the probability it will arrive within 40 minutes (exclusive, <40)?
SELECT 
  ROUND(
    COUNT(CASE
      WHEN TIMESTAMPDIFF(MINUTE, orders.order_date, orders.actual_delivery_time) < 40 
      THEN 1 
    END) / COUNT(*), 2
  ) AS P
FROM orders
WHERE DAYNAME(order_date) = 'Friday'
  AND TIME(order_date) >= '18:30:00'
  AND TIME(order_date) < '19:30:00'
  AND actual_delivery_time IS NOT NULL;
