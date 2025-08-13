#!/bin/bash

# Aguarda o banco estar pronto
echo "Aguardando o banco de dados iniciar..."
while ! nc -z $DATABASE_HOST $DATABASE_PORT; do
  sleep 1
done
echo "Banco de dados está pronto!"

# Executa migrações e coleta os arquivos estáticos
python manage.py migrate --noinput
python manage.py collectstatic --noinput

# Executa o comando final (passado no docker-compose)
exec gunicorn projeto.wsgi:application --bind 0.0.0.0:80
#exec python manage.py runserver 0.0.0.0:80

exec "$@"
