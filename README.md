# ntegrando uma API Flask com Microsoft OpenAI e Azure Cognitive Search: Hands-On

Projeto voltado para inteligência artificial com uso de documentos para 
conversação com linguagem natual e LLM (Large Language Model).

## Estrutura do Projeto

### `app.py`

Servidor web Flask que interage com a API do OpenAI.

#### Funcionalidades:
- Configuração do Flask e variáveis do OpenAI.
- Função `setup_byod` para configuração do BYOD para a API do OpenAI.
- Endpoint `/chat` para interação com o OpenAI.

#### Uso:
```bash
python app.py
```

---

### `Dockerfile`

Instruções para criar uma imagem Docker para a aplicação.

#### Características:
- Baseada em `python:3.8-slim`.
- Define variáveis de ambiente necessárias para a aplicação.
- Instala `make` e dependências Python.

#### Construção da Imagem:
```bash
docker build -t nome-da-imagem .
```

---

### `requirements.txt`

Dependências necessárias para a aplicação.

#### Conteúdo:
- Flask
- openai==0.28.1
- requests
- python-dotenv

---

### `makefile`

Automatiza tarefas como testes, construção e deploy.

#### Comandos:
- `test`: Executa testes unitários.
- `run-debug` / `run-prod`: Executa a aplicação em modos de depuração ou produção.
- `build`: Constrói a imagem Docker.
- `deploy`: Realiza o deploy da aplicação.

---

### `.gitlab-ci.yml`

Configuração do pipeline de CI/CD no GitLab.

#### Estágios:
- `test`: Executa testes unitários.
- `build`: Constrói a imagem Docker.
- `deploy`: Deploy da aplicação (somente na branch `master`).

---

## Utilização via CURL ou Postman

Instruções sobre como testar o projeto.

Para interagir com a rota `/chat` do seu aplicativo Flask via `curl` e Postman, você precisará criar uma solicitação POST que envia dados JSON. Vamos criar exemplos para ambos os casos.

### 1. Utilizando `curl`

O comando `curl` para enviar uma solicitação POST com dados JSON para a sua rota `/chat` seria algo assim:

```bash
curl -X POST http://localhost:5000/chat \
-H "Content-Type: application/json" \
-d '{"message_text": [{"role": "user", "content": "Sua mensagem aqui"}]}'
```

Neste comando:
- `-X POST` especifica que é uma requisição POST.
- `http://localhost:5000/chat` é a URL da sua rota Flask (ajuste conforme necessário).
- `-H "Content-Type: application/json"` define o cabeçalho para indicar que estamos enviando dados JSON.
- `-d` seguido pelo JSON é o corpo da solicitação, contendo a mensagem a ser enviada.

### 2. Utilizando Postman

Para enviar uma solicitação POST para a mesma rota usando Postman, siga estas etapas:

1. **Abra o Postman** e crie uma nova solicitação (request).

2. **Defina o Método e a URL**:
   - Escolha o método `POST` no menu suspenso.
   - Insira a URL da sua rota Flask, por exemplo: `http://localhost:5000/chat`.

3. **Configure o Cabeçalho**:
   - Vá para a aba "Headers".
   - Adicione uma nova chave `Content-Type` com o valor `application/json`.

4. **Adicione o Corpo da Solicitação**:
   - Mude para a aba "Body".
   - Selecione a opção "raw".
   - Escolha "JSON" como formato.
   - Insira o corpo da solicitação, que será algo como:
     ```json
     {
       "message_text": [{"role": "user", "content": "Sua mensagem aqui"}]
     }
     ```

5. **Envie a Solicitação**:
   - Clique no botão "Send".

Lembre-se de substituir `"Sua mensagem aqui"` pelo texto que você deseja enviar. Esses exemplos assumem que o servidor Flask está rodando localmente na porta 5000. Se estiver hospedado em outro lugar ou em uma porta diferente, ajuste a URL conforme necessário.

---

## Licença

Informações sobre a licença do projeto.


### Notas:

- **Licença**: Este projeto é licenciado por DNA TECHNOLOGY INNOVATIONS para fins educativos.
- **Criadores do Projeto**: 
  - Rodrigo Galhardo