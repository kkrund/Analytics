/*
Запрос выполняет LEFT JOIN между user_actions и users, соединяя по user_id.
Выбираются все действия пользователей с информацией о пользователях (пол и дата рождения),
при этом исключаются записи без соответствующего пользователя.
*/

SELECT user_actions.user_id as user_id_left,
       users.user_id as user_id_right,
       order_id,
       time,
       action,
       sex,
       birth_date
FROM   user_actions
    LEFT JOIN users
        ON user_actions.user_id = users.user_id
WHERE  users.user_id is not null
ORDER BY user_id_left
