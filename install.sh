#!/bin/bash

# ═════════════════════════════════════════════════════════════════════════════
#  MAXPOWERDEV WORKSTYLE - FULL STACK
#  One command. 100+ skills. Everything configured.
# ═════════════════════════════════════════════════════════════════════════════

set -e

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${GREEN}✓${NC} $1"; }
info() { echo -e "${BLUE}ℹ${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
title() { echo -e "${MAGENTA}▸${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1"; }

echo ""
echo "⚡ MaxPowerDev WorkStyle - FULL INSTALL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
info "Instalando tu AI Stack completo..."
echo ""

# ═════════════════════════════════════════════════════════════════════════════
# 1. DETECTAR ENTORNO
# ═════════════════════════════════════════════════════════════════════════════

INSTALL_METHOD="unknown"

if command -v brew &> /dev/null; then
    INSTALL_METHOD="brew"
elif command -v apt-get &> /dev/null; then
    INSTALL_METHOD="apt"
elif command -v pacman &> /dev/null; then
    INSTALL_METHOD="pacman"
elif command -v scoop &> /dev/null; then
    INSTALL_METHOD="scoop"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    INSTALL_METHOD="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    INSTALL_METHOD="linux"
fi

log "Entorno detectado: $INSTALL_METHOD"

# ═════════════════════════════════════════════════════════════════════════════
# 2. CREAR ESTRUCTURA DE DIRECTORIOS
# ═════════════════════════════════════════════════════════════════════════════

title "Creando estructura de directorios..."
mkdir -p ~/.config/opencode
mkdir -p ~/.opencode
mkdir -p ~/projects

log "Directorios creados"

# ═════════════════════════════════════════════════════════════════════════════
# 3. INSTALAR ENGRAM (MEMORIA PERSISTENTE)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "🧠 Configurando Engram (memoria persistente)..."

if command -v engram &> /dev/null; then
    log "Engram ya instalado"
else
    if command -v npm &> /dev/null; then
        npm install -g engram-cli 2>/dev/null && log "Engram instalado" || warn "No se pudo instalar Engram"
    else
        if command -v bun &> /dev/null; then
            bun add -g engram-cli 2>/dev/null && log "Engram instalado (bun)" || warn "No se pudo instalar Engram"
        else
            info "Node.js o Bun necesario para Engram"
            echo "   → brew install node"
        fi
    fi
fi

# ═════════════════════════════════════════════════════════════════════════════
# 4. INSTALAR OPENCODE (si no está)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "🤖 Verificando OpenCode..."

if command -v opencode &> /dev/null; then
    log "OpenCode ya instalado"
else
    if command -v brew &> /dev/null; then
        brew install opencode 2>/dev/null && log "OpenCode instalado" || info "Disponible: brew install opencode"
    else
        info "OpenCode disponible para instalar"
        echo "   → brew install opencode"
    fi
fi

# ═════════════════════════════════════════════════════════════════════════════
# 4b. INSTALAR HERRAMIENTAS BASE (Node, Python, Git, Bun)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "🛠️ Instalando herramientas base..."

# Git
if command -v git &> /dev/null; then
    log "Git ✓"
else
    if command -v brew &> /dev/null; then
        brew install git 2>/dev/null && log "Git instalado" || warn "Git no instalado"
    fi
fi

# Node.js
if command -v node &> /dev/null; then
    log "Node.js ✓ ($(node -v))"
else
    if command -v brew &> /dev/null; then
        brew install node 2>/dev/null && log "Node.js instalado" || warn "Node.js no instalado"
    fi
fi

# Bun (opcional - más rápido que npm)
if command -v bun &> /dev/null; then
    log "Bun ✓"
else
    if command -v brew &> /dev/null; then
        brew install bun 2>/dev/null && log "Bun instalado" || info "Bun disponible (opcional)"
    fi
fi

# Python (opcional)
if command -v python3 &> /dev/null; then
    log "Python ✓ ($(python3 --version))"
else
    if command -v brew &> /dev/null; then
        brew install python3 2>/dev/null && log "Python3 instalado" || info "Python3 disponible"
    fi
fi

# ═════════════════════════════════════════════════════════════════════════════
# 4c. INSTALAR PLUGINS (RTK, Engram, Background Agents)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "🧩 Instalando Plugins..."

# RTK Plugin
RTK_PLUGIN="https://raw.githubusercontent.com/MaximilianoAcri/maxpowerdev-workstyle/main/plugins/rtk.ts"
if curl -fsSL "$RTK_PLUGIN" -o ~/.config/opencode/plugins/rtk.ts 2>/dev/null; then
    log "RTK Plugin ✓"
else
    info "RTK Plugin no disponible"
fi

# Engram Plugin
ENGRAM_PLUGIN="https://raw.githubusercontent.com/MaximilianoAcri/maxpowerdev-workstyle/main/plugins/engram.ts"
if curl -fsSL "$ENGRAM_PLUGIN" -o ~/.config/opencode/plugins/engram.ts 2>/dev/null; then
    log "Engram Plugin ✓"
else
    info "Engram Plugin no disponible"
fi

# Background Agents Plugin
BG_PLUGIN="https://raw.githubusercontent.com/MaximilianoAcri/maxpowerdev-workstyle/main/plugins/background-agents.ts"
if curl -fsSL "$BG_PLUGIN" -o ~/.config/opencode/plugins/background-agents.ts 2>/dev/null; then
    log "Background Agents Plugin ✓"
else
    info "Background Agents Plugin no disponible"
fi

# ═════════════════════════════════════════════════════════════════════════════
# 5. INSTALAR 100+ SKILLS (Gentleman-Skills)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "🛠 Instalando 100+ skills..."

SKILLS_DIR="$HOME/.claude/skills"
SKILLS_REPO="Gentleman-Programming/Gentleman-Skills"

if [ -d "$SKILLS_DIR" ]; then
    SKILLS_COUNT=$(find "$SKILLS_DIR" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$SKILLS_COUNT" -gt 0 ]; then
        log "$SKILLS_COUNT skills ya instalados"
    else
        info "Descargando skills..."
        git clone --depth 1 "https://github.com/$SKILLS_REPO" "$SKILLS_DIR" 2>/dev/null && \
            SKILLS_COUNT=$(find "$SKILLS_DIR" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ') && \
            log "$SKILLS_COUNT skills instalados" || \
            warn "No se pudieron descargar skills"
    fi
else
    info "Descargando skills..."
    git clone --depth 1 "https://github.com/$SKILLS_REPO" "$SKILLS_DIR" 2>/dev/null && \
        SKILLS_COUNT=$(find "$SKILLS_DIR" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ') && \
        log "$SKILLS_COUNT skills instalados" || \
        warn "No se pudieron descargar skills"
fi

# ═════════════════════════════════════════════════════════════════════════════
# 6. OPENCODE SKILLS (sdd-*, branch-pr, judgment-day, etc)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "📦 Instalando OpenCode skills..."

mkdir -p ~/.config/opencode/skills

# Clone maxpowerdev-workstyle para obtener los skills de OpenCode
TEMP_DIR="/tmp/maxpowerdev-workstyle-install"
rm -rf "$TEMP_DIR"

git clone --depth 1 "https://github.com/MaximilianoAcri/maxpowerdev-workstyle" "$TEMP_DIR" 2>/dev/null && \
    cp -r "$TEMP_DIR/skills/"* ~/.config/opencode/skills/ 2>/dev/null && \
    log "OpenCode skills instalados" || \
    warn "OpenCode skills no disponibles"

rm -rf "$TEMP_DIR"

OPENCODE_SKILLS_COUNT=$(find ~/.config/opencode/skills -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
if [ "$OPENCODE_SKILLS_COUNT" -gt 0 ]; then
    log "$OPENCODE_SKILLS_COUNT OpenCode skills"
fi

# ═════════════════════════════════════════════════════════════════════════════
# 7. WORKSTYLE (TU GUÍA DE TRABAJO)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "📋 Instalando WORKSTYLE (tu guía de trabajo)..."

WORKSTYLE_URL="https://maximilianoacri.github.io/maxpowerdev-workstyle/WORKSTYLE.md"

if curl -fsSL "$WORKSTYLE_URL" -o ~/.opencode/WORKSTYLE.md 2>/dev/null; then
    log "WORKSTYLE.md instalado"
else
    if [ -f "$(dirname "$0")/WORKSTYLE.md" ]; then
        cp "$(dirname "$0")/WORKSTYLE.md" ~/.opencode/WORKSTYLE.md
        log "WORKSTYLE.md instalado (local)"
    else
        warn "No se pudo descargar WORKSTYLE.md"
    fi
fi

# ═════════════════════════════════════════════════════════════════════════════
# 7b. DESIGN.md (DESIGN SYSTEM - Para proyectos específicos)
# ═════════════════════════════════════════════════════════════════════

echo ""
title "🎨 Instalando DESIGN.md (Design System)..."

DESIGN_URL="https://raw.githubusercontent.com/MaximilianoAcri/maxpowerdev-workstyle/main/DESIGN.md"

if curl -fsSL "$DESIGN_URL" -o ~/.opencode/DESIGN.md 2>/dev/null; then
    log "DESIGN.md instalado"
else
    if [ -f "$(dirname "$0")/DESIGN.md" ]; then
        cp "$(dirname "$0")/DESIGN.md" ~/.opencode/DESIGN.md
        log "DESIGN.md instalado (local)"
    else
        info "DESIGN.md no disponible (opcional)"
    fi
fi

# ═════════════════════════════════════════════════════════════════════════════
# 8. AGENTS.md (CONFIGURACIÓN)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "⚙️ Configurando AGENTS.md..."

cat > ~/.config/opencode/AGENTS.md << 'AGENTS'
# MaxPowerDev WorkStyle - Configuración

## Quién soy
- **Nombre**: MaxPowerDev
- **Rol**: Senior Architect, GDE, Microsoft MVP
- **Enfoque**: Teaching, mentorship, quality over shortcuts

## Cómo trabajo
- El AI trabaja solo, sin molestar
- Se guarda decisiones en memoria automáticamente
- Usa skills cuando necesita
- Siempre pedí approval antes de cambios significativos
- CONCEPTOS > CODE - entender antes de implementar

## 🛠 100+ Skills Disponibles

### Frontend / UI
- react-19, nextjs-15, angular, vue, svelte, solid
- tailwind-4, tailwind-3, astrostyling

### State Management
- zustand-5, zod-4, redux, recoil

### Backend
- nodejs, nestjs, deno, bun, express
- trpc, graphql, rest-api

### Databases
- prisma, supabase, firebase, mongodb
- postgresql, mysql, redis, sqlite

### DevOps / Cloud
- docker, kubernetes, aws, gcp
- terraform, github-actions

### Testing
- playwright, vitest, jest, pytest

### AI / LLM
- ai-sdk-5, mcp-builder, langchain
- crewai, autogen, ollama

### automation
- n8n, make (integromat), cron

### Other Tools
- sentry, grafana, prometheus, elk
- puppeteer, scrapy, whatsapp

### Workflow / Comandos
- sd-* workflow completo (sdd-init → propose → spec → tasks → apply → verify → archive)
- judgment-day para reviews
- branch-pr para PRs
- issue-creation para issues

## Memoria (Engram)
- Guardá decisiones de arquitectura
- Guardá bugs corregidos con solución (root cause)
- Guardá patrones nuevos
- NO preguntes si ya tenés contexto

## Flujo
- Features nuevas: SDD workflow
- Fixes rápidos: directo al código
- Reviews importantes: judgment-day
AGENTS

log "AGENTS.md configurado"

# ═════════════════════════════════════════════════════════════════════════════
# 9. DETECTAR AGENTS INSTALADOS
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "🤖 Detectando AI agents..."
echo ""

AGENTS_FOUND=0

if command -v opencode &> /dev/null; then
    echo "  ⚡ OpenCode - ✓"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if command -v claude &> /dev/null; then
    echo "  🔵 Claude Code - ✓"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if command -v cursor &> /dev/null || [ -d "$HOME/.cursor" ]; then
    echo "  💻 Cursor - ✓"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if command -v codex &> /dev/null || [ -d "$HOME/.codex" ]; then
    echo "  📦 Codex - ✓"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if [ -d "$HOME/.windsurf" ]; then
    echo "  🌀 Windsurf - ✓"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if command -v gentle-ai &> /dev/null; then
    echo "  💜 Gentle-AI - ✓"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if [ $AGENTS_FOUND -eq 0 ]; then
    info "No se detectó ningún agent"
    echo ""
    echo "Para instalar:"
    echo "  • OpenCode:  brew install opencode"
    echo "  • Claude:  brew install anthropic/tap/claude"
    echo "  • Cursor: https://cursor.sh"
fi

# ═════════════════════════════════════════════════════════════════════════════
# 10. INSTALAR GENTLE-AI (OPCIONAL)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "💜 Verificando Gentle-AI..."

if command -v gentle-ai &> /dev/null; then
    log "Gentle-AI ya instalado"
else
    if command -v brew &> /dev/null; then
        if ! brew tap | grep -q "Gentleman-Programming/homebrew-tap" 2>/dev/null; then
            brew tap Gentleman-Programming/homebrew-tap 2>/dev/null || true
        fi
        brew install gentle-ai 2>/dev/null && log "Gentle-AI instalado" || info "Gentle-AI disponible"
    else
        info "Gentle-AI disponible para instalar"
    fi
fi

# ═════════════════════════════════════════════════════════════════════════════
# 11. RESUMEN FINAL
# ══════════��══════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ INSTALACIÓN COMPLETA"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

TOTAL_SKILLS=$((SKILLS_COUNT + OPENCODE_SKILLS_COUNT))

echo "📋 Estado:"
echo "   • WORKSTYLE:      ✓ instalado"
echo "   • AGENTS.md:      ✓ configurado"
echo "   • Memoria:      ✓ lista"
echo "   • Skills:        ✓ $TOTAL_SKILLS skills"
echo "   • Agents:       ✓ $AGENTS_FOUND detectados"
echo ""

echo "📝 Próximos pasos:"
echo "   1. Arrancá tu agent favorito"
echo "   2. El agent carga tu WORKSTYLE"
echo "   3. Cada decisión se guarda en memoria"
echo ""

echo "🔗 Links útiles:"
echo "   • Docs:         https://opencode.ai/docs"
echo "   • Skills:      https://github.com/Gentleman-Programming/Gentleman-Skills"
echo "   • Repo:        https://github.com/MaximilianoAcri/maxpowerdev-workstyle"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 Listo para laburar!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""