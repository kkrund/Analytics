/*
Выбираем товары с ценой выше 60 и названием, содержащим 'чай',
исключаем товары с названием 'чайный гриб'.
Добавляем колонку с фиксированной скидкой 25% и вычисляем новую цену.
*/
SELECT product_id,
       name,
       price,
       '25%' as discount,
       price*0.75 as new_price
FROM   products
WHERE  price > 60
   and name like '%чай%'
   and name not ilike '%чайный гриб%'
ORDER BY product_id
