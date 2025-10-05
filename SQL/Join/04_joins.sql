/*
Запрос подсчитывает количество уникальных дат рождения среди пользователей и курьеров.
Используется UNION для объединения дат рождения из таблиц users и couriers,
исключая пустые значения (NULL).
*/

SELECT count(*) as dates_count
FROM   (SELECT birth_date
        FROM   users
        WHERE  birth_date is not null
        UNION
SELECT birth_date
        FROM   couriers
        WHERE  birth_date is not null) as t1
