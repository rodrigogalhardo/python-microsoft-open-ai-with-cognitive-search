import json
from app import app


def test_chat_endpoint():
    # Cria um cliente de teste para o app Flask
    client = app.test_client()

    # Simula uma mensagem de entrada
    test_message = {
        "message_text": [{"role": "user", "content": "Quais são os tipos de deposito PIX?"}]
    }

    # Envia a mensagem para a rota /chat e recebe a resposta
    response = client.post('/chat',
                           data=json.dumps(test_message),
                           content_type='application/json')

    # Verifica se a resposta é adequada
    assert response.status_code == 200
    # Aqui, você pode adicionar mais verificações conforme necessário
