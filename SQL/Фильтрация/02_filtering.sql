/* Запрос выбирает 10 последних доставленных заказов (deliver_order) курьера с courier_id = 100.
Результат сортируется по времени выполнения в порядке убывания, чтобы сначала отображались самые свежие доставки.
*/
SELECT order_id,
       time
FROM   courier_actions
WHERE  courier_id = 100
   and action = 'deliver_order'
ORDER BY time desc limit 10
