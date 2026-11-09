SERVICES_WITH_CONTRACTS := incidents backend

.PHONY: up up-apps prepare down reset ps logs env

env: ## Crea .env a partir de .env.example si no existe
	@test -f .env || cp .env.example .env

up: env ## Levanta solo bases de datos y NATS
	docker compose up -d --wait

prepare: ## Genera los stubs de contratos en los repos que los necesitan
	@for s in $(SERVICES_WITH_CONTRACTS); do \
		echo "==> proto: beacon-$$s"; \
		$(MAKE) -C ../beacon-$$s proto || exit 1; \
	done

up-apps: env prepare ## Construye y levanta infraestructura + aplicaciones
	docker compose --profile apps up -d --build --wait

down: ## Detiene todo (conserva los datos)
	docker compose --profile apps down

reset: ## Detiene todo y BORRA los datos
	docker compose --profile apps down -v

ps: ## Estado de los contenedores
	docker compose --profile apps ps

logs: ## Logs en vivo
	docker compose --profile apps logs -f
