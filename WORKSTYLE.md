# MaxPowerDev Work Style

Configuración estándar para proyectos. Basada en la forma de trabajar de MaxPowerDev (Martinelli + proyectos).

## Quick Start

```bash
# 1. Copiar este archivo a tu home
cp WORKSTYLE.md ~/.opencode/WORKSTYLE.md
```

## Overview

| Herramienta | Propósito |
|------------|----------|
| **OpenCode** | Agente principal de desarrollo |
| **Engram** | Memoria persistente |
| **80+ Skills** | Patrones de frameworks |

## Reglas de Trabajo

### Antes de hacer cambios significativos
- ✅ Mostrar propuesta primero al usuario
- ✅ Esperar aprobación antes de ejecutar
- ✅ Documentar decisiones en memoria

### Tipos de cambios
| Tipo | Acción |
|------|--------|
| Bug simple | Corregir y verificar |
| Feature simple | Mostrar propuesta, esperar OK |
| Feature compleja | Considerar SDD workflow |

### Cuándo usar SDD
- Proyectos nuevos o complejos
- Múltiples features interrelated
- Arquitectura por definir

## Comandos

```bash
# Guardar memoria
mem_save --title "Fix X" --type bugfix --content "Qué, por qué, dónde"

# Ver memoria
mem_context
```

## Memoria - Qué guardar

- Arquitectura/decisión de diseño
- Bug fix (con root cause)
- Convención establecida
- Descubrimiento no obvious
- Preferencia del usuario

## Formato

```
**What**: Qué se hizo
**Why**: Por qué (motivación)  
**Where**: Dónde (archivos)
**Learned**: Gotchas, edge cases
```

## Skills Principales

- Next.js 15, React 19, Tailwind 4
- Prisma, Supabase
- Playwright, Vitest
- GitHub Actions, Docker

---

*Creado: 2026-04-18*
*Autor: MaxPowerDev*