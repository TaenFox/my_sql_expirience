SET @date_start='{{ Период.start }}';                                     --Указание даты начала периода
SET @date_end='{{ Период.end }}';                                         --Указание даты окончания периода
SET @is_all_categ = (if("Все категории" IN ({{ cat }}),TRUE, FALSE));     --Проверка и определение на применение фильтра по категориям
SET @is_all_usr = (if("Все сотрудники" IN ({{ usr }}),TRUE, FALSE));      --Проверка и определение на применение фильтра по сотрудникам
SET @is_all_cc = (if("Все КЦ" IN ({{ cc }}),TRUE, FALSE));                --Проверка и определение на применение фильтра по колцентрам

SELECT date_format(created_at, '%Y-%m-%d') AS `Дата создания`,
       if(@is_all_cc,'Все КЦ',                                            --если фильтр по КЦ не применим - пишем в поле "все кц"
            (SELECT                                                       --иначе уточняем какой указан кц
               (SELECT c1.name                                            --название кц получаем из соответствующей таблицы
                FROM drivers d1                                           --по связи с пользователем
                LEFT JOIN call_center c1 ON d1.call_center = c1.code
                WHERE d1.id=driver_support_request_comments.user_id)
             FROM driver_support_request_comments                         --пользователя выбираем на основе комментариев в заявке
             WHERE request_id = dsr.id
               AND                                                        --пользователь, оставивший комментарий должен иметь роль
                 (SELECT ROLE
                  FROM drivers
                  WHERE id=driver_support_request_comments.user_id)<>11   --не соответствующую роли водителя
               AND user_id<>18346351                                      --и id не соответствующий роботу
             ORDER BY created_at ASC                                      --берём первый комментарий в хроно порядке
             LIMIT 1)) AS `Колцентр`,
       if(@is_all_usr,'Все сотрудники',                                   ---\
            (SELECT                                                       -- |
               (SELECT CONCAT(last_name,' ',name, ' ', middle_name)       -- |
                FROM drivers                                              -- |
                WHERE id=driver_support_request_comments.user_id)         -- |
             FROM driver_support_request_comments                         -- |
             WHERE request_id = dsr.id                                    -- |
               AND                                                        --  >   аналогичным образом берём информацию по ФИО сотрудника
                 (SELECT ROLE                                             -- |
                  FROM drivers                                            -- |
                  WHERE id=driver_support_request_comments.user_id)<>11   -- |
               AND user_id<>18346351                                      -- |
             ORDER BY created_at ASC                                      -- |
             LIMIT 1)) AS `Сотрудник`,                                    ---/
       if(@is_all_categ,'Все категории',                                  --проверяем применимость фильтра по категориям
            (SELECT tt.title
             FROM driver_support_topics t
             LEFT JOIN driver_support_topic_types tt ON t.type_id=tt.id
             WHERE dsr.topic_id=t.id)) AS `Категория`,                    --и указываем категорию
       if(@is_all_categ,'Все категории',                                  --проверяем применимость фильтра по категориям
            (SELECT t.title
             FROM driver_support_topics t
             WHERE dsr.topic_id=t.id)) AS `Подкатегория`,                 --и указываем подкатегорию
       count(*) AS `Заявок всего`,                                        --дальше аналитическая часть - считаем количество заявок и их соответствие критериям
       sum(IF (dsr.driver_feedback_status IS NOT NULL, 1,0)) AS `Заявок оценено`,
       sum(IF (dsr.driver_feedback_status=1, 1,0)) AS `Помогло`,          --оценка водителем чата с поддержкой
       sum(IF (dsr.driver_feedback_status=0, 1,0)) AS `Не помогло`
FROM driver_support_requests dsr                                          --для этого запроса используется одна базовая таблица
WHERE created_at BETWEEN @date_start AND @date_end                        --фильтр по диапазону дат
GROUP BY `Дата создания`,                                                 --каскад группировки позволяет сделать ступенчатый вывод информации в таблицу
         `Колцентр`,
         `Сотрудник`,
         `Категория`,
         `Подкатегория`
  /*Далее идёт блок фильтрации итоговой выборки
    для применения/неприменения условия фильтрации
    используется логическое выражение. 
    Если фильтрация применима выполняется блок условия
    Если фильтрация не применима - возвращается TRUE и весь блок фильтрации игнорируется

    Если проигнорировать все блоки фильтрации следующее выражение будет эквивалентно выражению
    HAVING TRUE AND TRUE AND TRUE
  */
HAVING if(!@is_all_usr,`Сотрудник` IN ({{ usr }}),TRUE)
AND if(!@is_all_cc,`Колцентр` IN ({{ cc }}),TRUE)
AND if(!@is_all_categ,concat(`Категория`,' - ',`Подкатегория`) IN ({{ cat }}),TRUE)
