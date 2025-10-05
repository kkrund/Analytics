/*
Запрос выбирает отмененные заказы из таблицы user_actions,
совершенные в августе, в среду, с 12 до 15 часов.
Результат сортируется по order_id в порядке убывания.
*/
SELECT user_id,
       order_id,
       action,
       time
FROM   user_actions
WHERE  action = 'cancel_order'
   and date_part('month', time) = 8
   and date_part('dow', time) = 3
   and date_part('hour', time) between 12
   and 15
ORDER BY order_id desc
