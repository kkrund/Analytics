/*
Запрос вычисляет среднее количество товаров в заказах для каждого пользователя,
исключая отмененные заказы.
Используется LEFT JOIN между отфильтрованными действиями пользователей и таблицей orders по order_id.
*/

SELECT user_id,
       round(avg(array_length(product_ids, 1)), 2) as avg_order_size
FROM   (SELECT user_id,
               order_id
        FROM   user_actions
        WHERE  order_id not in (SELECT order_id
                                FROM   user_actions
                                WHERE  action = 'cancel_order')) t1
    LEFT JOIN orders using(order_id)
GROUP BY user_id
ORDER BY user_id 
