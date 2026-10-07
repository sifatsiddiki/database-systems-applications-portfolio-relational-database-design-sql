
Student ID:40735842_
11. Find the order in the database which has the wrong delivery charge applied?
SELECT
  o.id AS order_id,
  ROUND(SUM(fi.price * oi.quantity), 2) AS items_total,
  CASE
    WHEN SUM(fi.price * oi.quantity) < 10 THEN 3
    WHEN SUM(fi.price * oi.quantity) >= 10 AND SUM(fi.price * oi.quantity) < 20 THEN 2
    WHEN SUM(fi.price * oi.quantity) >= 20 AND SUM(fi.price * oi.quantity) < 30 THEN 1
    WHEN SUM(fi.price * oi.quantity) >= 30 THEN 0
  END AS delivery,
  ROUND(SUM(fi.price * oi.quantity), 2) +
    CASE
      WHEN SUM(fi.price * oi.quantity) < 10 THEN 3
      WHEN SUM(fi.price * oi.quantity) >= 10 AND SUM(fi.price * oi.quantity) < 20 THEN 2
      WHEN SUM(fi.price * oi.quantity) >= 20 AND SUM(fi.price * oi.quantity) < 30 THEN 1
      WHEN SUM(fi.price * oi.quantity) >= 30 THEN 0
    END AS total,
  o.delivery_charge AS stored_delivery_charge,
  o.total_price AS stored_total
FROM orders o
JOIN order_item oi ON o.id = oi.order_id
JOIN food_item fi ON oi.food_item_id = fi.id
GROUP BY o.id, o.delivery_charge, o.total_price
HAVING
  (items_total < 10 AND o.delivery_charge != 3)
  OR (items_total >= 10 AND items_total < 20 AND o.delivery_charge != 2)
  OR (items_total >= 20 AND items_total < 30 AND o.delivery_charge != 1)
  OR (items_total >= 30 AND o.delivery_charge != 0);

