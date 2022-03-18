SET @id_driver = '{{ driver }}';        --указание водителя
SET @date_start = '{{ date.start }}';   --Начало периода
SET @date_end = '{{ date.end }}';       --Окончание периода

SELECT concat('https://city-mobil.ru/taxiserv/order/',o.id) as `Заказ`,
       o.OrderedDate as `Дата`,
       concat('https://city-mobil.ru/taxiserv/city/tariff/',t.id) as `Тариф`,
       t.admin_name as `Название тарифа`,
       if(s.id is null, 'Нет','Да') as `Вошёл в ГД`,
       if(count(l.id)>1,'Есть другой ГД','') As `Несколько ГД`,
       if(l.id is not null,concat('https://city-mobil.ru/taxiserv/driver_surcharge/edit/',l.id),'') as `ГД`,
       l.admin_title as `Название ГД`
FROM order_closed o
LEFT JOIN tariff1 t ON o.tariff=t.id
LEFT JOIN driver_surcharge_orders s ON o.id=s.order_id
LEFT JOIN driver_surcharge_list l ON s.surcharge_id=l.id
WHERE o.status = 'CP'
  AND o.Driver = @id_driver
  AND o.OrderedDate BETWEEN @date_start AND @date_end
  GROUP BY 1
  ORDER BY 2
