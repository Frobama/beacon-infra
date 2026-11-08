# beacon-infra

Infraestructura de **Beacon**. En esta fase: entorno local con Docker Compose. Más adelante: Helm charts, manifiestos de Kubernetes y la app de demo que se rompe a propósito.

## Requisitos

Docker y Docker Compose v2, y `make`.

## Uso

```bash
make up      # crea .env si falta y levanta todo
make ps      # estado
make logs    # logs
make down    # detiene (conserva datos)
make reset   # detiene y borra datos
```

## Servicios y puertos

| Servicio | Imagen | Puerto local | Lo usa |
|---|---|---|---|
| `nats` | nats:2.10 | 4222 (cliente), 8222 (monitoreo) | Backend, Incidentes, Notificaciones |
| `alerts-db` | TimescaleDB (PG16) | 5433 | `beacon-alerts` |
| `incidents-db` | PostgreSQL 16 | 5434 | `beacon-incidents` |
| `notifications-db` | MongoDB 7 | 27017 | `beacon-notifications` |

Cada servicio tiene **su propia base de datos**; nunca se comparten tablas ni colecciones.

## Cadenas de conexión (valores por defecto)

```text
Alertas:         postgres://beacon:beacon@localhost:5433/alerts
Incidentes:      postgres://beacon:beacon@localhost:5434/incidents
Notificaciones:  mongodb://beacon:beacon@localhost:27017/notifications?authSource=admin
NATS:            nats://localhost:4222
```

Monitoreo de NATS: <http://localhost:8222>

## Hoja de ruta de este repo

- Fase 0: Docker Compose (este estado).
- Fase 1: se agregan los contenedores de cada servicio.
- Fase 3: Helm charts y despliegue en Kubernetes (kind).
- Fase 5: app de demo y RBAC para el MCP.
