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

## Skills principales

- **Frontend**: Next.js 15, React 19, React Native, Tailwind 4, Angular
- **Backend**: Prisma, Supabase, Django DRF, Deno
- **Testing**: Playwright, Vitest, Pytest
- **DevOps**: GitHub Actions, GCP, Cron, n8n
- **AI**: Vercel AI SDK 5, MCP Builder

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