import openai
import requests
import os
from flask import Flask, request, jsonify
from dotenv import load_dotenv


app = Flask(__name__)

# Define o modo de depuração com base na variável de ambiente
# 1 ativa o modo de depuração, e 0 o desativa.
app.debug = os.environ.get('FLASK_DEBUG') == '1'

# Carregar configurações do ambiente
openai.api_type = os.getenv('OPENAI_API_TYPE', 'azure')
openai.api_version = os.getenv('OPENAI_API_VERSION', '2023-08-01-preview')
openai.api_base = os.getenv('OPENAI_API_BASE')
openai.api_key = os.getenv('OPENAI_API_KEY')
deployment_id = os.getenv('DEPLOYMENT_ID')

search_endpoint = os.getenv('SEARCH_ENDPOINT')
search_key = os.getenv('SEARCH_KEY')
search_index_name = os.getenv('SEARCH_INDEX_NAME')


# Função de configuração BYOD para o OpenAI
def setup_byod(deployment_id):
    class BringYourOwnDataAdapter(requests.adapters.HTTPAdapter):
        def send(self, request, **kwargs):
            request.url = f"{openai.api_base}/openai/deployments/{deployment_id}/extensions/chat/completions?api-version={openai.api_version}"
            return super().send(request, **kwargs)

    session = requests.Session()
    session.mount(prefix=f"{openai.api_base}/openai/deployments/{deployment_id}", adapter=BringYourOwnDataAdapter())
    openai.requestssession = session


setup_byod(deployment_id)


@app.route('/chat', methods=['POST'])
def chat():
    message_text = request.json.get("message_text")
    completion = openai.ChatCompletion.create(
        messages=message_text,
        deployment_id=deployment_id,
        dataSources=[
            {
                "type": "AzureCognitiveSearch",
                "parameters": {
                    "endpoint": search_endpoint,
                    "key": search_key,
                    "indexName": search_index_name,
                }
            }
        ]
    )

    # Decodificando a string para o formato normal
    decoded_text = completion.choices[0].message.content.encode('latin1').decode('unicode_escape')
    print(decoded_text)

    return jsonify(decoded_text)


if __name__ == '__main__':
    app.run(debug=True)
    if app.debug:
        load_dotenv()  # Carrega as variáveis de ambiente do arquivo .env apenas em modo de debug


