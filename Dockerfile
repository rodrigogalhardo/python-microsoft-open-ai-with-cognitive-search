FROM python:3.8-slim
LABEL authors="Rodrigo Galhardo - TechLab, Arquitetura e Inovação Tecnologica"

FROM python:3.8-slim
# Argumentos de build
ARG OPENAI_API_TYPE
ARG OPENAI_API_VERSION
ARG OPENAI_API_BASE
ARG OPENAI_API_KEY
ARG DEPLOYMENT_ID
ARG SEARCH_ENDPOINT
ARG SEARCH_KEY
ARG SEARCH_INDEX_NAME

# Definiçao de variáveis de ambiente no container
ENV OPENAI_API_TYPE=$OPENAI_API_TYPE
ENV OPENAI_API_VERSION=$OPENAI_API_VERSION
ENV OPENAI_API_BASE=$OPENAI_API_BASE
ENV OPENAI_API_KEY=$OPENAI_API_KEY
ENV DEPLOYMENT_ID=$DEPLOYMENT_ID
ENV SEARCH_ENDPOINT=$SEARCH_ENDPOINT
ENV SEARCH_KEY=$SEARCH_KEY
ENV SEARCH_INDEX_NAME=$SEARCH_INDEX_NAME

WORKDIR /app

# Copiar apenas o requirements.txt inicialmente para reuso do cache e das camadas do Docker
COPY requirements.txt requirements.txt

# Instalar dependências, incluindo 'make'
RUN apt-get update && \
    apt-get install -y make && \
    pip install -r requirements.txt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copiar o resto do código fonte
COPY . .

CMD ["flask", "run", "--host=0.0.0.0"]
