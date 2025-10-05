/*
CTE sub1 разворачивает массив product_ids для всех заказов.
CTE sub2 оставляет только уникальные пары order_id и product_id.
Основной запрос подсчитывает, сколько раз каждый товар был доставлен курьером в сентябре 2022.
Выбираются топ-10 самых доставленных товаров, результат сортируется по количеству доставок по убыванию.
*/
with sub1 as (SELECT order_id, unnest(product_ids) as product_id
FROM   orders), 
sub2 as (SELECT DISTINCT order_id, product_id FROM   sub1)
SELECT name,
       count(*) as times_purchased
FROM   sub2 join courier_actions using(order_id) join products using(product_id)
WHERE  date_part('month', time) = 9
   and date_part('year', time) = 2022
   and action = 'deliver_order'
GROUP BY name
ORDER BY times_purchased desc limit 10;
