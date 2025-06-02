#!/bin/bash

# Проверяем, установлен ли python3
if ! command -v python3 &> /dev/null; then
    echo "Python3 не установлен. Устанавливаем..."
    pkg install python -y
fi

# Определяем доступный Python-сервер
if python3 -c "import http.server" &> /dev/null; then
    SERVER="python3 -m http.server"
elif python3 -c "import SimpleHTTPServer" &> /dev/null; then
    SERVER="python3 -m SimpleHTTPServer"
else
    echo "Не удалось найти подходящий модуль для запуска сервера"
    exit 1
fi

# Получаем IP-адрес устройства
IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

if [ -z "$IP" ]; then
    IP="localhost"
fi

# Запускаем сервер
echo "Сервер запущен:"
echo "Откройте в браузере: http://$IP:8000"
echo "Для остановки сервера нажмите Ctrl+C"

$SERVER 8000