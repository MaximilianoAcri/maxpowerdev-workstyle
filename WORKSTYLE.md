# MaxPowerDev Work Style

Configuración personalizada para OpenCode + Engram. Mi forma personal de trabajar con AI agents.

## Quick Start

```bash
# Copiar a tu config de OpenCode
cp WORKSTYLE.md ~/.opencode/WORKSTYLE.md
```

## Overview

| Herramienta | Propósito |
|------------|----------|
| **OpenCode** | Agente de desarrollo principal |
| **Engram** | Memoria persistente automática |
| **80+ Skills** | Patrones para frameworks |

## Reglas de Trabajo

### Antes de ejecutar cambios significativos
- ✅ Mostrar propuesta primero
- ✅ Esperar aprobación
- ✅ Documentar decisiones en memoria

### Por tipo de cambio
| Tipo | Acción |
|------|--------|
| Bug simple | Corregir y verificar |
| Feature | Mostrar propuesta, esperar OK |
| Complejo | Usar SDD workflow |

### Cuándo usar SDD
- Proyectos nuevos o complejos
- Múltiples features interrelated
- Arquitectura por definir

## Memoria - Cuándo guardar

- Arquitectura / decisión de diseño
- Bug fix (con root cause)
- Convención establecida
- Descubrimiento no obvious
- Preferencia del usuario

## Formato de memoria

```
**What**: Qué se hizo
**Why**: Por qué (motivación)  
**Where**: Dónde (archivos)
**Learned**: Gotchas, edge cases
```

## Skills principales (100+ disponibles)

### 🖥️ Frontend / UI
React 19, Next.js 15, Angular (core/forms/performance), Vue 3, Svelte, Solid, Tailwind 4, Astro

### ⚡ State
Zustand 5, Zod 4, TypeScript strict, Redux Toolkit

### 🖥️ Backend
Node.js, NestJS, Deno, Bun, Express, tRPC, GraphQL, Django DRF, Spring Boot 3

### 💾 Databases
Prisma, Supabase, Firebase, MongoDB, PostgreSQL, MySQL, Redis, SQLite

### ☸️ DevOps / Cloud
Docker, Kubernetes, AWS, GCP, Terraform, GitHub Actions

### 🧪 Testing
Playwright, Vitest, Jest, Pytest, Go Testing

### 🤖 AI / LLM
Vercel AI SDK 5, MCP Builder, LangChain, CrewAI, LangGraph, AutoGen, Ollama

### 🔧 automation
n8n, Make (Integromat), Cron

### 📊 Monitoring
Sentry, Grafana, Prometheus, ELK Stack

### 🔨 Other Tools
Puppeteer, Scrapy, WhatsApp API, Webhooks, Bash Scripting

### ⚙️ Workflow / Commands (OpenCode)
sdd-init, sdd-propose, sdd-spec, sdd-tasks, sdd-apply, sdd-verify, sdd-archive, sdd-design, sdd-explore, sdd-onboard, judgment-day, branch-pr, issue-creation, skill-creator, skill-registry, go-testing

## Comandos útiles

```bash
# Guardar en memoria
mem_save --title "Fix X" --type bugfix --content "Qué, por qué, dónde"

# Ver contexto reciente
mem_context

# Buscar en memoria
mem_search "query"
```

---

*Creado: 2026-04-18*
*Autor: MaxPowerDev*