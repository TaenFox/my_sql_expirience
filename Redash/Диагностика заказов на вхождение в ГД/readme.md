# Диагностика заказов на вхождение в ГД
Этот запрос написан для диагностики заказов, которые совершает водитель, на предмет вхождения в программу мотивации гарантированного дохода
# Параметры
|Параметр|Тип|
|--|--|
|driver|строка|
|Date|диапазон даты и времени|
# Пример вывода
|Заказ|Дата|Тариф|Название тарифа|Вошёл в ГД|Несколько ГД|ГД|Название ГД|
|--|--|--|--|--|--|--|--|
|https://city-mobil.ru/taxiserv/order/2655181855|17/10/21 12:23|https://city-mobil.ru/taxiserv/city/tariff/6471|Эконом Адлер|Да|https://city-mobil.ru/taxiserv/driver_surcharge/edit/7283|Адлер бренд - c 12.10.21|
|https://city-mobil.ru/taxiserv/order/2655439435|17/10/21 14:52|https://city-mobil.ru/taxiserv/city/tariff/6471|Эконом Адлер|Нет|
|https://city-mobil.ru/taxiserv/order/2655459187|17/10/21 15:03|https://city-mobil.ru/taxiserv/city/tariff/6731|Эконом порт - Адлер|Нет|
|https://city-mobil.ru/taxiserv/order/2655618567|17/10/21 16:32|https://city-mobil.ru/taxiserv/city/tariff/6471|Эконом Адлер|Да|https://city-mobil.ru/taxiserv/driver_surcharge/edit/7283|Адлер бренд - c 12.10.21|
https://city-mobil.ru/taxiserv/order/2655698783|17/10/21 17:15|https://city-mobil.ru/taxiserv/city/tariff/6471|Эконом Адлер|Да|https://city-mobil.ru/taxiserv/driver_surcharge/edit/7283|Адлер бренд - c 12.10.21|
https://city-mobil.ru/taxiserv/order/2655727215|17/10/21 17:30|https://city-mobil.ru/taxiserv/city/tariff/6471|Эконом Адлер|Да|https://city-mobil.ru/taxiserv/driver_surcharge/edit/7283|Адлер бренд - c 12.10.21|
https://city-mobil.ru/taxiserv/order/2655866435|17/10/21 18:40|https://city-mobil.ru/taxiserv/city/tariff/6731|Эконом порт - Адлер|Нет|
