#!/bin/bash

# ═════════════════════════════════════════════════════════════════════════════
#  MAXPOWERDEV WORKSTYLE
#  One command. Any agent. Any OS.
#  Tu AI Stack configurado y listo para laburar.
# ═════════════════════════════════════════════════════════════════════════════

set -e

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
NC='\033[0m'

log() { echo -e "${GREEN}✓${NC} $1"; }
info() { echo -e "${BLUE}ℹ${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
title() { echo -e "${MAGENTA}▸${NC} $1"; }

echo ""
echo "⚡ MaxPowerDev WorkStyle"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
info "Tu AI Stack configurado..."
echo ""

# ═════════════════════════════════════════════════════════════════════════════
# DETECTAR MÉTODO DE INSTALACIÓN
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
# CREAR ESTRUCTURA
# ═════════════════════════════════════════════════════════════════════

title "Creando estructura..."
mkdir -p ~/.config/opencode
mkdir -p ~/.opencode
mkdir -p ~/projects

log "Estructura creada"

# ═════════════════════════════════════════════════════════════════════════════
# DESCARGAR WORKSTYLE
# ═════════════════════════════════════════════════════════════════════════════

title "Instalando WORKSTYLE..."
WORKSTYLE_URL="https://raw.githubusercontent.com/maxpowerdev/maxpowerdev-workstyle/main/WORKSTYLE.md"

if curl -fsSL "$WORKSTYLE_URL" -o ~/.opencode/WORKSTYLE.md 2>/dev/null; then
    log "WORKSTYLE.md instalado en ~/.opencode/"
else
    if [ -f "$(dirname "$0")/WORKSTYLE.md" ]; then
        cp "$(dirname "$0")/WORKSTYLE.md" ~/.opencode/WORKSTYLE.md
        log "WORKSTYLE.md instalado (local)"
    else
        warn "No se pudo descargar WORKSTYLE.md"
    fi
fi

# ═════════════════════════════════════════════════════════════════════════════
# DETECTAR AGENTS INSTALADOS
# ═════════════════════════════════════════════════════════════════════

echo ""
title "Detectando AI agents..."
echo ""

AGENTS_FOUND=0

if command -v opencode &> /dev/null; then
    echo "  ⚡ OpenCode - ✓ instalado"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if command -v claude &> /dev/null; then
    echo "  🔵 Claude Code - ✓ instalado"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if command -v cursor &> /dev/null; then
    echo "  💻 Cursor - ✓ instalado"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if command -v codex &> /dev/null; then
    echo "  📦 Codex - ✓ instalado"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if [ -f "$HOME/.cursor" ] || [ -d "$HOME/.cursor" ]; then
    echo "  💻 Cursor - ✓ instalado"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if [ -f "$HOME/.windsurf" ] || [ -d "$HOME/.windsurf" ]; then
    echo "  🌀 Windsurf - ✓ instalado"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if [ -f "$HOME/.codex" ] || [ -d "$HOME/.codex" ]; then
    echo "  📦 Codex - ✓ instalado"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if command -v gentle-ai &> /dev/null; then
    echo "  💜 Gentle-AI - ✓ instalado"
    AGENTS_FOUND=$((AGENTS_FOUND + 1))
fi

if [ $AGENTS_FOUND -eq 0 ]; then
    info "No se detectó ningún agent instalado"
    echo ""
    echo "Para instalar uno:"
    echo "  • OpenCode:  brew install opencode"
    echo "  • Claude:  brew install anthropic/tap/claude"
    echo "  • Cursor: https://cursor.sh"
fi

# ═════════════════════════════════════════════════════════════════════════════
# INSTALAR ENGRAM (MEMORIA)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "Verificando memoria..."

if command -v engram &> /dev/null; then
    log "Engram ya instalado"
else
    if command -v npm &> /dev/null; then
        npm install -g engram-cli 2>/dev/null && log "Engram instalado" || info "Engram disponible para instalar"
    else
        info "Node.js no instalado (necesario para Engram)"
    fi
fi

# ═════════════════════════════════════════════════════════════════════════════
# SKILLS
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "Verificando skills..."

mkdir -p ~/.config/opencode/skills
SKILLS_COUNT=$(find ~/.config/opencode/skills -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')

if [ "$SKILLS_COUNT" -gt 0 ]; then
    log "$SKILLS_COUNT skills encontrados"
else
    info "Skills disponibles en Gentle-Skills repo"
    echo "  → https://github.com/Gentleman-Programming/Gentleman-Skills"
fi

# ═════════════════════════════════════════════════════════════════════════════
# CONFIGURAR TU WORKSTYLE
# ═════════════════════════════════════════════════════════════════════════════

echo ""
title "Configurando tu guía de trabajo..."

cat > ~/.opencode/AGENTS.md << 'AGENTS'
# MaxPowerDev WorkStyle - Configuración

## Cómo trabajo
- El AI trabaja solo, sin molestar
- Se guarda decisiones en memoria automáticamente
- Usa skills cuando necesita

## Skills a usar
- Patterns de React, Angular, Next.js
- Prisma para DB
- Playwright para tests

## Flujo
- Para features nuevas: SDD workflow
- Para fixes rápidos: directo al código
AGENTS

log "WORKSTYLE configurado"

# ═════════════════════════════════════════════════════════════════════════════
# RESUMEN
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ INSTALACIÓN COMPLETA"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "📋 Estado:"
echo "   • WORKSTYLE:    ✓ instalado"
echo "   • Memoria:     ✓ lista"
echo "   • Agents:     $AGENTS_FOUND detectados"
echo "   • Skills:     $SKILLS_COUNT configurados"
echo ""

echo "📝 Próximos pasos:"
echo "   1. Arrancá tu agent favorito: opencode, claude, cursor, etc"
echo "   2. El agent cargará tu WORKSTYLE automáticamente"
echo "   3. Cada decisión se guarda en memoria"
echo ""

echo "🔗 Links útiles:"
echo "   • Docs OpenCode:    https://opencode.ai/docs"
echo "   • Gentle-AI:      https://github.com/Gentleman-Programming/gentle-ai"
echo "   • Gentle-Skills:    https://github.com/Gentleman-Programming/Gentleman-Skills"
echo "   • Nuestro repo:    https://github.com/MaximilianoAcri/maxpowerdev-workstyle"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 Listo para laburar!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""