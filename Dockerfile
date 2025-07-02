# Use uma imagem base oficial do Python.
# python:3.10-slim é uma boa escolha por ser leve.
# coloquei a 3.13.5-alpine3.22, para teste pois foi indicado que ela era mais leve
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho no container
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker
COPY requirements.txt .

# Instala as dependências
# --no-cache-dir para manter a imagem menor
RUN pip install --no-cache-dir -r requirements.txt

# Copia o resto do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta que a aplicação vai rodar
EXPOSE 8000

# Comando para rodar a aplicação com uvicorn
# Use --host 0.0.0.0 para tornar a aplicação acessível de fora do container
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000","--reload"]

