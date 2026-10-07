Student ID:40735842-
14. Who are the people who have placed entirely vegetarian orders and who share the same first and last name?
WITH vegetarian_orders AS (
SELECT DISTINCT o.customer_id
FROM orders o
JOIN order_item oi ON o.id = oi.order_id
JOIN food_item fi ON oi.food_item_id = fi.id
WHERE fi.vegetarian = 1
AND NOT EXISTS (
SELECT 1
FROM order_item oi2
JOIN food_item fi2 ON oi2.food_item_id = fi2.id
WHERE oi2.order_id = o.id AND fi2.vegetarian = 0
)
)
SELECT
u1.id AS id1,
u2.id AS id2,
u1.first_name,
u1.last_name
FROM users u1
JOIN users u2 ON u1.first_name = u2.first_name
AND u1.last_name = u2.last_name
AND u1.id < u2.id
WHERE u1.id IN (SELECT customer_id FROM vegetarian_orders)
AND u2.id IN (SELECT customer_id FROM vegetarian_orders)
ORDER BY u1.first_name, u1.last_name;
