#!/usr/bin/env bash

INPUT_FILES="tolstoj_lew_nikolaewich-text_1.txt tolstoj_lew_nikolaewich-text_2.txt tolstoj_lew_nikolaewich-text_3.txt tolstoj_lew_nikolaewich-text_4.txt"
OUTPUT_FILE="word_statistics.csv"

# Используем Perl для извлечения слов по UTF-8 (кириллица и латиница)
cat $INPUT_FILES | \
tr '[:upper:]' '[:lower:]' | \
perl -CSD -nE 'while (/(\p{L}+)/gu) { say $1 }' | \
sort | \
uniq -c | \
sort -nr > tmp_wordstat.txt

echo "word,count" > $OUTPUT_FILE
awk '{print $2 "," $1}' tmp_wordstat.txt >> $OUTPUT_FILE

rm tmp_wordstat.txt
