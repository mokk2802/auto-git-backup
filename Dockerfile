FROM alpine:latest

#Установка git и bash
RUN apk add --no-cache git bash

WORKDIR /app

#Копируем спкрипт
COPY git-task.sh /usr/local/bin/git-task.sh
RUN chmod +x /usr/local/bin/git-task.sh

#Запускаем скрипт при запуске контейнера
CMD ["/usr/local/bin/git-task.sh"]