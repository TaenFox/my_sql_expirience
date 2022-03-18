SELECT  s.k AS `Коэффициент`,
        if(s.k>=1,'Увеличение количества заказов',
            if(s.k<0.7,
              '!Критическое уменьшение количества заказов!',
              'Уменьшение количества заказов')
          ) AS `Оценка`
FROM
  (SELECT
      (
             (SELECT count(*)
              FROM fairbot_suggests_success
              WHERE date_suggest
                BETWEEN
                  NOW() - interval 10 MINUTE
                AND
                  NOW())
              /
             (SELECT count(*)
              FROM fairbot_suggests_success
              WHERE date_suggest
                BETWEEN
                  NOW() - INTERVAL 20 MINUTE
                AND
                  NOW() - INTERVAL 10 MINUTE)
      )
  AS 'k') AS s
