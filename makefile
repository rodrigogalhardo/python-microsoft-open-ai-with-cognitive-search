.PHONY: test build deploy run-debug run-prod load-env

DOCKER_IMAGE_NAME ?= py-ai-api

load-env:
	@if [ -f .env ]; then \
		set -a; \
		source .env; \
		set +a; \
	fi

test: load-env
	pytest -v

run-debug: load-env
	FLASK_DEBUG=1 python app.py

run-prod: load-env
	FLASK_DEBUG=0 python app.py

build: load-env
	docker build --build-arg OPENAI_API_TYPE=$$OPENAI_API_TYPE \
				 --build-arg OPENAI_API_VERSION=$$OPENAI_API_VERSION \
				 --build-arg OPENAI_API_BASE=$$OPENAI_API_BASE \
				 --build-arg OPENAI_API_KEY=$$OPENAI_API_KEY \
				 --build-arg DEPLOYMENT_ID=$$DEPLOYMENT_ID \
				 --build-arg SEARCH_ENDPOINT=$$SEARCH_ENDPOINT \
				 --build-arg SEARCH_KEY=$$SEARCH_KEY \
				 --build-arg SEARCH_INDEX_NAME=$$SEARCH_INDEX_NAME \
				 -t $(DOCKER_IMAGE_NAME) .

deploy: load-env
	ecs-deploy -c my-cluster -n my-service -i minha-api-flask:latest
