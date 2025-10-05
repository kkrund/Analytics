/*
Запрос вычисляет средний размер заказа (количество товаров) в зависимости от дня недели:
'weekend' для субботы и воскресенья
'weekdays' для остальных дней
*/

SELECT case when date_part('dow', creation_time) in (0, 6) then 'weekend'
            else 'weekdays' end as week_part,
       round(avg(array_length(product_ids, 1)), 2) as avg_order_size
FROM   orders
GROUP BY week_part
ORDER BY avg_order_size
