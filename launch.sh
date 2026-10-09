#!/bin/bash

# Переходим в директорию со скриптом (гарантированно в папку ComfyUI)
cd "$(dirname "$(readlink -f "$0")")" || exit 1

# Активируем виртуальное окружение
if [ -f ".env/bin/activate" ]; then
    source .env/bin/activate
else
    echo "Ошибка: не найдено виртуальное окружение .env/bin/activate"
    read -rp "Нажмите Enter для выхода..."
    exit 1
fi

URL="http://127.0.0.1:8188"

# Запускаем ComfyUI в фоне
python3 main.py --enable-manager &
COMFY_PID=$!

trap 'kill "$COMFY_PID" 2>/dev/null; exit' INT TERM

# Ждём готовности сервера и открываем браузер
for i in {1..60}; do
    if ! kill -0 "$COMFY_PID" 2>/dev/null; then
        echo "ComfyUI завершился неожиданно."
        wait "$COMFY_PID"
        exit $?
    fi

    if curl -s -o /dev/null "$URL"; then
        xdg-open "$URL" >/dev/null 2>&1 &
        break
    fi
    sleep 1
done

wait "$COMFY_PID"
deactivate