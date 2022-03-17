SET @id_user = '{{ Id_user }}';         --указание пользователя
SET @id_vigil = '{{ Id_vigil }}';       --указание смены
SET @date_start = '{{ Date_start }}';   --Начало периода
SET @date_end = '{{ Date_end }}';       --Окончание периода

SELECT bh.id_user AS `Пользователь`,
       bh.id_vigil AS `Смена`,
       bh.date_start AS `Начало перерыва`,
       bh.date_end AS `Окончание перерыва`,
       ROUND(TIME_TO_SEC(TIMEDIFF(bh.date_end,bh.date_start))/60) AS `Время перерыва`,
       bt.name AS `Тип перерыва`
FROM staff_break_history bh
LEFT JOIN vigil_break_type vbt ON bh.id_vigil_break_type=vbt.id
LEFT JOIN break_types bt ON vbt.id_break_type=bt.id
WHERE (@id_user='-' OR bh.id_user = @id_user)
  AND (@id_vigil='-' OR bh.id_vigil = @id_vigil)
  AND bh.date_start BETWEEN @date_start AND @date_end

UNION

SELECT id_user,
       id_vigil,
       "",
       "Всего",
       SUM(ROUND(TIME_TO_SEC(TIMEDIFF(bh.date_end,bh.date_start))/60)) AS break,
       ""
FROM staff_break_history bh
LEFT JOIN vigil_break_type vbt ON bh.id_vigil_break_type=vbt.id
LEFT JOIN break_types bt ON vbt.id_break_type=bt.id
WHERE (@id_user='-' OR bh.id_user = @id_user)
  AND (@id_vigil='-' OR bh.id_vigil = @id_vigil)
  AND bh.date_start BETWEEN @date_start AND @date_end
GROUP BY id_user

ORDER BY `Пользователь`, `Начало перерыва` DESC
