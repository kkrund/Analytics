/*
CTE выбирает курьеров с количеством доставленных заказов >= 30 за сентябрь 2022.
Основной запрос получает информацию о этих курьерах: дату рождения и пол.
*/
with subquery_1 as (SELECT courier_id,
                           count(order_id)
                    FROM   courier_actions
                    WHERE  action = 'deliver_order'
                       and time between '2022-09-01'
                       and '2022-10-01'
                    GROUP BY courier_id having count(order_id) >= 30)
SELECT courier_id,
       birth_date,
       sex
FROM   couriers
WHERE  courier_id in (SELECT courier_id
                      FROM   subquery_1)
ORDER BY courier_id
