.PHONY: up down reset ps logs env

env: ## Crea .env a partir de .env.example si no existe
	@test -f .env || cp .env.example .env

up: env ## Levanta bases de datos y NATS
	docker compose up -d --wait

down: ## Detiene los contenedores (conserva los datos)
	docker compose down

reset: ## Detiene y BORRA los datos
	docker compose down -v

ps: ## Estado de los contenedores
	docker compose ps

logs: ## Logs en vivo
	docker compose logs -f
