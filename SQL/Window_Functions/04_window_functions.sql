/*
Запрос определяет тип заказа для каждого пользователя: 'Первый' или 'Повторный' с помощью оконной функции min() OVER.
Подсчитывает количество заказов каждого типа по датам, исключаются отмененные заказы.
*/

SELECT time::date as date,
       order_type,
       count(order_id) as orders_count
FROM   (SELECT user_id,
               order_id,
               time,
               case when time = min(time) OVER (PARTITION BY user_id) then 'Первый'
                    else 'Повторный' end as order_type
        FROM   user_actions
        WHERE  order_id not in (SELECT order_id
                                FROM   user_actions
                                WHERE  action = 'cancel_order')) t
GROUP BY date, order_type
ORDER BY date, order_type
