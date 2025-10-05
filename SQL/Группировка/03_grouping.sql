/*
Запрос группирует пользователей по возрастным категориям:
'18-24', '25-29', '30-35', '36+'
Считает количество пользователей в каждой возрастной группе.
Фильтруются только записи с заполненной датой рождения.
*/

SELECT case when date_part('year', age(birth_date)) between 18 and
                 24 then '18-24'
            when date_part('year', age(birth_date)) between 25 and
                 29 then '25-29'
            when date_part('year', age(birth_date)) between 30 and
                 35 then '30-35'
            else '36+' end as group_age,
       count(*) as users_count
FROM   users
WHERE  birth_date is not null
GROUP BY group_age
ORDER BY group_age
