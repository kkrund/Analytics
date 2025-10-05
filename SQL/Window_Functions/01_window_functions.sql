/*
Запрос вычисляет для каждого товара максимальную цену среди всех товаров (max_price)
и долю цены товара относительно максимальной (share_of_max) с помощью оконной функции.
Результат сортируется по цене по убыванию, а при одинаковой цене — по product_id.
*/

SELECT product_id,
       name,
       price,
       max(price) OVER() as max_price,
       round(price/max(price) OVER(), 2) as share_of_max
FROM   products
ORDER BY price desc, product_id
