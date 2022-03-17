SET @date_start = '{{ date1 }}';  --Начало периода
SET @date_end = '{{ date2 }}';    --Окончание периода

SELECT cc.name as `КЦ`,   --коллцентр оператора
       concat(op.last_name, ' ', op.name, ' ', op.middle_name) AS `ФИО сотрудника`,
       concat('https://city-mobil.ru/cdr?call=', с.uniqueid) as `ID`,  --ссылка на запись звонка для прослушивания
       oo.refuse_reason_text AS 'Причина звонка'
FROM cdr с    --таблица с записями звонков
left JOIN drivers op ON cdr.id_user = op.id
left JOIN call_center cc ON cc.code=op.call_center
left JOIN order_record oo ON oo.call_uniqueid = cdr.uniqueid
WHERE с.direction = "incoming"
  AND с.redirected_to <> ""       --без переадресации
  AND с.calltime BETWEEN @date_start AND @date_end
  AND с.target = "city_operators"       --очередь входящих звонков
  AND op.role = 52    --роль оператора
