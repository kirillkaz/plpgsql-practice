FROM postgres:16

# Копируем скрипты инициализации
COPY migrations/*.sql /docker-entrypoint-initdb.d/

# Если используем дамп:
# COPY dumps/my_dump.sql /docker-entrypoint-initdb.d/