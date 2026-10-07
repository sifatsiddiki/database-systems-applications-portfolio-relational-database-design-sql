Student ID:40735842
12. How are orders distributed over the day and over the week? Count all orders starting on the hour and before the start of the next hour?
SELECT * FROM (
  SELECT
    DAYNAME(o.order_date) AS day,
    SUM(CASE WHEN HOUR(o.order_date) = 11 THEN 1 ELSE 0 END) AS `1100`,
    SUM(CASE WHEN HOUR(o.order_date) = 12 THEN 1 ELSE 0 END) AS `1200`,
    SUM(CASE WHEN HOUR(o.order_date) = 13 THEN 1 ELSE 0 END) AS `1300`,
    SUM(CASE WHEN HOUR(o.order_date) = 14 THEN 1 ELSE 0 END) AS `1400`,
    SUM(CASE WHEN HOUR(o.order_date) = 15 THEN 1 ELSE 0 END) AS `1500`,
    SUM(CASE WHEN HOUR(o.order_date) = 16 THEN 1 ELSE 0 END) AS `1600`,
    SUM(CASE WHEN HOUR(o.order_date) = 17 THEN 1 ELSE 0 END) AS `1700`,
    SUM(CASE WHEN HOUR(o.order_date) = 18 THEN 1 ELSE 0 END) AS `1800`,
    SUM(CASE WHEN HOUR(o.order_date) = 19 THEN 1 ELSE 0 END) AS `1900`,
    SUM(CASE WHEN HOUR(o.order_date) = 20 THEN 1 ELSE 0 END) AS `2000`,
    SUM(CASE WHEN HOUR(o.order_date) = 21 THEN 1 ELSE 0 END) AS `2100`
  FROM orders o
  GROUP BY DAYNAME(o.order_date)

  UNION ALL

  SELECT
    'All days' AS day,
    SUM(CASE WHEN HOUR(o.order_date) = 11 THEN 1 ELSE 0 END),
    SUM(CASE WHEN HOUR(o.order_date) = 12 THEN 1 ELSE 0 END),
    SUM(CASE WHEN HOUR(o.order_date) = 13 THEN 1 ELSE 0 END),
    SUM(CASE WHEN HOUR(o.order_date) = 14 THEN 1 ELSE 0 END),
    SUM(CASE WHEN HOUR(o.order_date) = 15 THEN 1 ELSE 0 END),
    SUM(CASE WHEN HOUR(o.order_date) = 16 THEN 1 ELSE 0 END),
    SUM(CASE WHEN HOUR(o.order_date) = 17 THEN 1 ELSE 0 END),
    SUM(CASE WHEN HOUR(o.order_date) = 18 THEN 1 ELSE 0 END),
    SUM(CASE WHEN HOUR(o.order_date) = 19 THEN 1 ELSE 0 END),
    SUM(CASE WHEN HOUR(o.order_date) = 20 THEN 1 ELSE 0 END),
    SUM(CASE WHEN HOUR(o.order_date) = 21 THEN 1 ELSE 0 END)
  FROM orders o
) AS summary
ORDER BY
  FIELD(day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday', 'All days');
