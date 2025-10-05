/*
Запрос вычисляет ежедневный доход (revenue) по всем заказам,
исключая отмененные пользователями.
Массив product_ids разворачивается с помощью unnest, затем JOIN с таблицей products для суммирования цен.
Результат группируется по дате создания заказа.
*/

SELECT date(creation_time) as date,
       sum(price) as revenue
FROM   (SELECT order_id,
               creation_time,
               product_ids,
               unnest(product_ids) as product_id
        FROM   orders
        WHERE  order_id not in (SELECT order_id
                                FROM   user_actions
                                WHERE  action = 'cancel_order')) t1 join products using(product_id)
GROUP BY date
