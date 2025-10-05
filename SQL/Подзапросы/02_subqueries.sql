/*
CTE считает количество созданных заказов для каждого пользователя.
Основной запрос сравнивает количество заказов пользователя с средним и вычисляет разницу.
*/
with sub1 as (SELECT user_id,
                     count(order_id) as orders_count
              FROM   user_actions
              WHERE  action = 'create_order'
              GROUP BY user_id)
SELECT user_id,
       orders_count,
       round((SELECT avg(orders_count)
       FROM   sub1), 2) as orders_avg, orders_count- round((SELECT avg(orders_count)
                                                     FROM   sub1), 2) as orders_diff
FROM   sub1
ORDER BY user_id limit 1000
