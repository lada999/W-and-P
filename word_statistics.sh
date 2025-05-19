#!/bin/bash

# Список исходных файлов
INPUT_FILES="tolstoj_lew_nikolaewich-text_1.txt tolstoj_lew_nikolaewich-text_2.txt tolstoj_lew_nikolaewich-text_4.txt"
# Имя результирующего файла
OUTPUT_FILE="word_statistics.csv"

# Обработка:
# 1. Объединяем все файлы
# 2. Переводим все буквы к нижнему регистру
# 3. Заменяем всё, что не буквы или цифры, на пробел
# 4. Разбиваем по словам (по одному на строку)
# 5. Удаляем пустые строки
# 6. Сортируем слова
# 7. Считаем частоту каждого слова
# 8. Сортируем по убыванию частоты
# 9. Сохраняем в формате CSV (word,count)

cat $INPUT_FILES | \
tr '[:upper:]' '[:lower:]' | \
tr -c '[:alnum:]' '[\n*]' | \
grep -v '^$' | \
sort | \
uniq -c | \
sort -nr | \
awk 'BEGIN{OFS=","; print "word,count"} {print $2,$1}' > $OUTPUT_FILE

echo "Статистика сохранена в $OUTPUT_FILE"
