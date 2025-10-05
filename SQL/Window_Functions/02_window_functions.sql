/*
Запрос нумерует заказы каждого пользователя с помощью row_number(),
вычисляет время предыдущего заказа (lag) и разницу между заказами (time_diff).
Исключаются отмененные заказы.
*/

SELECT user_id,
       order_id,
       time,
       row_number() OVER (PARTITION BY user_id
                          ORDER BY time) as order_number,
       lag(time, 1) OVER (PARTITION BY user_id
                          ORDER BY time) as time_lag,
       time - lag(time, 1) OVER (PARTITION BY user_id
                                 ORDER BY time) as time_diff
FROM   user_actions
WHERE  order_id not in (SELECT order_id
                        FROM   user_actions
                        WHERE  action = 'cancel_order')
ORDER BY user_id, order_number 
