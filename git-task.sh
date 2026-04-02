#!/bin/bash
# Скрипт для автоматической отправки изменений в репозиторий GitHub
set -e
echo "Starting Git backup process..."

# 2. Очистка переменных (удаляем пробелы и возможные символы переноса строки \r)
CLEAN_TOKEN=$(echo "$GITHUB_TOKEN" | tr -d '\r' | xargs)
CLEAN_REPO=$(echo "$GIT_REPO" | tr -d '\r' | xargs)
CLEAN_USER=$(echo "$GIT_USER" | tr -d '\r' | xargs)
CLEAN_EMAIL=$(echo "$GIT_EMAIL" | tr -d '\r' | xargs)

# 3. Настройка окружения Git
git config --global user.name "$CLEAN_USER"
git config --global user.email "$CLEAN_EMAIL"

# 4. Формирование URL с токеном для аутентификации
REMOTE_URL="https://${CLEAN_USER}:${CLEAN_TOKEN}@${CLEAN_REPO}"

# Проверка наличия изменений
git add .

if git diff --cached --quiet; then
    echo "No changes to commit"
else
    # 5. Коммит изменений
    git commit -m "Automated backup: $(date +'%Y-%m-%d %H:%M:%S')"

    # 6. Отправка изменений в удаленный репозиторий
    git push "$REMOTE_URL" HEAD:main
    echo "Changes pushed to GitHub successfully."
fi