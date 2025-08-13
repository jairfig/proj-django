# Base image
FROM python:3.13-slim

# Diretório de trabalho
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    netcat-openbsd \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copiar os arquivos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
