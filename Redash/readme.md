#Запросы для Redash
В данном разделе указаны запросы, оптимизированные для работы на платформе Redash (https://redash.io/). В запросах встречаются конструкции типа `{{ date1 }}` - это указание параметров, которые используются в графическом интерфейсе.
При выполнении запроса эти параметры заменяются на строковые выражения, поэтому обычно они обрамляются в кавычки. Исключением служат конструкции `... WHERE id IN ({{items}})...`: в таком случае параметры выбираются как "несколько из списка" и каждый отдельно заключен в кавычках