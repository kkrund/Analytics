/*
CTE разворачивает массив product_ids для всех заказов, которые не были отменены.
CTE counts считает, сколько раз каждый товар был куплен, и выбирает топ-10 самых популярных товаров.
Основной запрос выводит product_id и количество покупок, сортируя по product_id.
*/
with sub_1 as (SELECT unnest(product_ids) as product_id
               FROM   orders
               WHERE  order_id not in (SELECT order_id
                                       FROM   user_actions
                                       WHERE  action = 'cancel_order')), counts as (SELECT product_id,
                                                    count(*) as times_purchased
                                             FROM   sub_1
                                             GROUP BY product_id
                                             ORDER BY times_purchased desc limit 10)
SELECT product_id,
       times_purchased
FROM   counts
ORDER BY product_id;
