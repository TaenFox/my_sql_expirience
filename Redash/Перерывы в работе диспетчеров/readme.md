# Перерывы в работе диспетчеров
Запрос выводит список перерывов диспетчеров на смене с датой/временем начала и окончания перерыва, продолжительностью и причиной перерыва. Строки сгруппированы по пользователям, отсортированы по времени. В конце группы указан совокупная продолжительность перерывов за указанный период
# Параметры
|Параметр|Тип|
|--|--|
|Id_user|строка|
|Id_vigil|строка|
|Date_start|дата и время|
|Date_end|дата и время|
# Пример вывода
|Пользователь|Смена|Начало перерыва|Окончание перерыва|Время перерыва|Тип перерыва|
|--|--|--|--|--|--|
|22354903|25662447|2021-07-09 10:59:37|2021-07-09 11:05:32|6.00	|Курилка|
|22354903|25662447|2021-07-09 10:25:09|2021-07-09 10:29:54|5.00|Чай|
|22354903|25662447|2021-07-09 09:32:11|2021-07-09 09:41:44|10.00|Чай|
|22354903|25662447|2021-07-09 08:33:17|2021-07-09 08:38:15|5.00|Курилка|
|22354903|25662447|2021-07-09 08:26:57|2021-07-09 08:32:09|5.00|Курилка|
|22354903|25662447||Всего|31.00||
