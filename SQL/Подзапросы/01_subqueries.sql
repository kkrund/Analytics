/*
Запрос пересчитывает цену товара в зависимости от отклонения от средней:
выше средней+50 → скидка 15%
ниже средней-50 → скидка 10%
*/
SELECT product_id,
       name,
       price,
       case when price > (SELECT round(avg(price), 2)
                   FROM   products)+50 then price*0.85 when price < (SELECT round(avg(price), 2)
                                                  FROM   products)-50 then price*0.9 else price end as new_price
FROM   products
ORDER BY price desc, product_id
