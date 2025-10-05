/*
Запрос выбирает пользователей, их заказы и список товаров по каждому заказу,
исключая заказы, которые были отменены пользователями.
Используется JOIN между таблицами user_actions и orders по order_id.
Результат сортируется по user_id и order_id и ограничен 1000 строками.
*/

SELECT user_id,
       user_actions.order_id,
       product_ids
FROM   user_actions join orders
        ON user_actions.order_id = orders.order_id
WHERE  user_actions.order_id not in (SELECT order_id
                                     FROM   user_actions
                                     WHERE  action = 'cancel_order')
ORDER BY user_id, user_actions.order_id limit 1000
