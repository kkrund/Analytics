/*
Запрос вычисляет среднее количество товаров в заказах для каждого пользователя,
исключая отмененные заказы.
Используется JOIN между user_actions и orders по order_id.
Результат группируется по user_id и ограничен 1000 строками.
*/
SELECT user_id,
       round(avg(array_length(product_ids, 1)), 2) as avg_order_size
FROM   user_actions join orders
        ON user_actions.order_id = orders.order_id
WHERE  user_actions.order_id not in (SELECT order_id
                                     FROM   user_actions
                                     WHERE  action = 'cancel_order')
GROUP BY user_id
ORDER BY user_id limit 1000
