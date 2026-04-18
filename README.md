# MaxPowerDev Work Style

Configuración personalizada para trabajar con AI agents (OpenCode + Engram) en cualquier proyecto. Más de 80 skills para desarrollo web, mobile, DevOps y más.

![OpenCode](https://img.shields.io/badge/OpenCode-v1.3.17-blue)
![Engram](https://img.shields.io/badge/Engram-persistent-green)
![Skills](https://img.shields.io/badge/Skills-80+-orange)

## ¿Para qué sirve?

Si trabajás con AI coding assistants (OpenCode, Claude, Cursor, etc.), esta configuración hace que:

- 🤖 El AI **pregunte antes de hacer cambios importantes** (nada de committed sin aviso)
- 🧠 **Guarde automáticamente** decisiones arquitectura, bugs fixados, y aprendizajes en memoria persistente
- 🛠 Tengas los **mismos skills** en todos tus proyectos (Next.js, React, Angular, Prisma, etc.)
- 📋 Se aplique tu **guía de trabajo** en cada sesión

En síntesis: un setup personalizable para que el AI trabaje como vos querés.

## Quick Install

```bash
# Opción 1: Script automático
curl -sL https://raw.githubusercontent.com/maxpowerdev/maxpowerdev-workstyle/main/install.sh | bash

# Opción 2: Manual
cp WORKSTYLE.md ~/.opencode/WORKSTYLE.md
```

## Requisitos

- [OpenCode](https://opencode.ai) instalado: `brew install opencode`
- Git

## Features

| Feature | Descripción |
|---------|-------------|
| ⚙️ OpenCode Config | WORKSTYLE.md con reglas de comportamiento |
| 🧠 Engram Memory | Persistencia automático de decisiones |
| 🛠 80+ Skills | Para frameworks, testing, DevOps, AI |
| 📋 Contribución | Guidelines para agregar skills |

## Estructura

```
maxpowerdev-workstyle/
├── WORKSTYLE.md       # Config principal (reglas AI)
├── README.md          # Este archivo
├── install.sh         # Script de instalación
└── .gitignore        # Para ignorar secretos
```

## Skills disponibles

### Frontend
`nextjs-15`, `react-19`, `react-native`, `tailwind-4`, `angular-core`, `angular-architecture`

### Backend & Database
`prisma`, `supabase`, `django-drf`, `deno`

### Testing
`playwright`, `vitest`, `pytest`, `go-testing`

### DevOps & Cloud
`github-actions`, `gcp`, `cron`, `n8n`

### AI & Automation
`ai-sdk-5`, `mcp-builder`, `webhooks`, `make`

### Observability
`prometheus`, `grafana`, `sentry`, `elk`

## Cómo funciona

1. **Install**: Copiá `WORKSTYLE.md` a tu config de OpenCode
2. **Iniciá una sesión**: El AI carga tu configuración automáticamente
3. **Trabajá**: Cada decisión importante se guarda en memoria
4. **Seguí**: Engram persaistirá lo aprendido entre sesiones

## Contributing

¿Querés agregar skills o改进 la config? Issues y PRs bienvenidos.

## Inspirado en

- [gentle-ai](https://github.com/Gentleman-Programming/gentle-ai)
- [opencode-configs](https://github.com/5kahoisaac/opencode-configs)
- [opencode-synced](https://github.com/iHildy/opencode-synced)

---

⭐ From MaxPowerDev with ❤️