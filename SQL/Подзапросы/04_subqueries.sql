/*
Запрос вычисляет время доставки для заказов с более чем 5 товарами,
которые не были отменены пользователями.
- time_accepted — время принятия заказа курьером
- time_delivered — время доставки
- delivery_time — разница в минутах между принятием и доставкой
*/
SELECT order_id,
       max(case when action = 'accept_order' then time end) as time_accepted,
       max(case when action = 'deliver_order' then time end) as time_delivered,
       round(extract(epoch
FROM   (max(case when action = 'deliver_order' then time end) - max(case when action = 'accept_order' then time end))) / 60)::integer as delivery_time
FROM   courier_actions
WHERE  order_id in (SELECT order_id
                    FROM   orders
                    WHERE  array_length(product_ids, 1) > 5)
   and order_id not in (SELECT order_id
                     FROM   user_actions
                     WHERE  action = 'cancel_order')
GROUP BY order_id
ORDER BY order_id
