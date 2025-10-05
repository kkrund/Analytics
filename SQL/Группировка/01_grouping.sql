/*
Запрос рассчитывает для каждого пользователя:
- количество созданных заказов (orders_count)
- долю отмененных заказов относительно созданных (cancel_rate)
Фильтрация через HAVING оставляет только тех пользователей, 
которые создали больше 3 заказов и имеют коэффициент отмен >= 0.5.
*/
SELECT user_id,
       count(order_id) filter (WHERE action = 'create_order') as orders_count,
       round(cast(count(*) filter (WHERE action = 'cancel_order') as decimal) / count(order_id) filter (WHERE action = 'create_order'),
             2) as cancel_rate
FROM   user_actions
GROUP BY user_id having count(order_id) filter (
WHERE  action = 'create_order') > 3
   and round(cast(count(*) filter (
WHERE  action = 'cancel_order') as decimal) / count(order_id) filter (
WHERE  action = 'create_order'), 2) >= 0.5
ORDER BY user_id
