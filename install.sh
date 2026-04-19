#!/bin/bash

# ═════════════════════════════════════════════════════════════════════════════
#  MAXPOWERDEV WORKSTYLE - Setup Profesional para AI Coding
# ═════════════════════════════════════════════════════════════════════════════

set -e

echo "🚀 MaxPowerDev WorkStyle"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}✓${NC} $1"; }
info() { echo -e "${BLUE}ℹ${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }

# ═════════════════════════════════════════════════════════════════════════════
# MENÚ PRINCIPAL
# ═════════════════════════════════════════════════════════════════════════════

echo "¿Qué querés instalar?"
echo ""
echo "  1) 🟢 BÁSICO      - WORKSTYLE + Memoria (recomendado)"
echo "  2) 🟣 COMPLETO    - Todo el ecosistema + Skills"
echo "  3) 🟡 ACTUALIZAR - Mantené todo al día"
echo "  4) ❓ VER ESTADO  - Qué tengo instalado?"
echo ""

read -p "Opción [1-4]: " option

case $option in
    1) install_basic ;;
    2) install_complete ;;
    3) install_update ;;
    4) show_status ;;
    *) install_basic ;;
esac

# ═════════════════════════════════════════════════════════════════════════════════════
# INSTALACIÓN BÁSICA
# ═════════════════════════════════════════════════════════════════════════════

install_basic() {
    echo ""
    info "Instalando versión básica..."
    echo ""
    
    mkdir -p ~/.opencode
    mkdir -p ~/.config/opencode
    
    # Copiar WORKSTYLE
    WORKSTYLE_URL="https://raw.githubusercontent.com/maxpowerdev/maxpowerdev-workstyle/main/WORKSTYLE.md"
    if curl -fsSL "$WORKSTYLE_URL" -o ~/.opencode/WORKSTYLE.md 2>/dev/null; then
        log "WORKSTYLE.md instalado en ~/.opencode/"
    else
        # Si estamos en el directorio mismo
        if [ -f "$(dirname "$0")/WORKSTYLE.md" ]; then
            cp "$(dirname "$0")/WORKSTYLE.md" ~/.opencode/WORKSTYLE.md
            log "WORKSTYLE.md instalado (local)"
        else
            warn "No se pudo descargar WORKSTYLE.md"
        fi
    fi
    
    # Verificar OpenCode
    echo ""
    if command -v opencode &> /dev/null; then
        log "OpenCode instalado: $(opencode --version 2>/dev/null || echo 'ok')"
    else
        info "OpenCode no está instalado todavía"
        echo "   → brew install opencode"
    fi
    
    show_status
}

# ═════════════════════════════════════════════════════════════════════════════════════
# INSTALACIÓN COMPLETA (Con RTK + Skills)
# ═════════════════════════════════════════════════════════════════════════════

install_complete() {
    echo ""
    info "Instalando versión COMPLETA..."
    echo ""
    
    # Lo básico primero
    install_basic
    
    echo ""
    info "Instalando ecosistema completo..."
    
    # Instalar OpenCode (si no está)
    if command -v opencode &> /dev/null; then
        log "OpenCode listo ✓"
    else
        if command -v brew &> /dev/null; then
            brew install opencode 2>/dev/null || info "Instalá OpenCode manualmente"
        fi
    fi
    
    # Instalar Node/npm para Engram y más
    if command -v npm &> /dev/null; then
        log "Node/NPM listo ✓"
    else
        warn "Node.js no está instalado"
        echo "   → brew install node"
    fi
    
    # Crear estructura de proyectos
    mkdir -p ~/projects
    
    # Crear alias útiles
    PROFILE="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && PROFILE="$HOME/.zshrc"
    
    if ! grep -q "# MaxPowerDev WorkStyle" "$PROFILE" 2>/dev/null; then
        cat >> "$PROFILE" << 'ALIAS'

# MaxPowerDev WorkStyle
alias mpw="cd ~/projects"
alias mpw-new="mkdir ~/projects/\$(basename \$PWD) && cd \$_"
alias mpw-skills="find ~/.config/opencode/skills -name SKILL.md | wc -l"
alias mpw-status='echo "=== MaxPowerDev WorkStyle ===" && echo "OpenCode:" && which opencode && echo "Skills:" && mpw-skills'
ALIAS
        log "Alias creados en $PROFILE"
    fi
    
    echo ""
    info "Agregando skills extras..."
    
    # Skills que se van a ofrecer (no instalar automáticamente para no romper nada)
    echo ""
    echo "📦 Skills disponibles para agregar manualmente:"
    echo "   • @reduxjs/toolkit  - RTK para React/Vue apps"
    echo "   • nextjs-15        - Next.js 15 App Router"
    echo "   • react-19         - React 19 + Compiler"
    echo "   • angular-core     - Angular standalone + signals"
    echo "   • prisma          - ORM type-safe"
    echo "   • supabase        - Firebase alternative"
    echo "   • playwright      - E2E testing"
    echo "   • tailwind-4      - CSS moderno"
    echo "   • vite            - Build tool"
    echo ""
    echo "   → https://github.com/maxpowerdev/maxpowerdev-workstyle#skills"
    
    show_status
}

# ═════════════════════════════════════════════════════════════════════════════
# ACTUALIZAR
# ═════════════════════════════════════════════════════════════════════════════

install_update() {
    echo ""
    info "Actualizando WorkStyle..."
    
    # Actualizar WORKSTYLE
    WORKSTYLE_URL="https://raw.githubusercontent.com/maxpowerdev/maxpowerdev-workstyle/main/WORKSTYLE.md"
    if curl -fsSL "$WORKSTYLE_URL" -o ~/.opencode/WORKSTYLE.md 2>/dev/null; then
        log "WORKSTYLE.md actualizado"
    fi
    
    # Actualizar configuración
    if [ -f ~/.opencode/AGENTS.md ]; then
        WORKSTYLE_CONTENT=$(cat ~/.opencode/WORKSTYLE.md 2>/dev/null)
        if echo "$WORKSTYLE_CONTENT" | grep -q "approval"; then
            log "Configuración actualizada"
        fi
    fi
    
    show_status
}

# ═════════════════════════════════════════════════════════════════════════════
# MOSTRAR ESTADO
# ═════════════════════════════════════════════════════════════════════════════

show_status() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📊 ESTADO ACTUAL"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    echo -n "🤖 OpenCode:      "
    if command -v opencode &> /dev/null; then
        echo "✓ instalado"
    else
        echo "✗ no instalado"
    fi
    
    echo -n "🧠 Engram:       "
    if command -v engram &> /dev/null; then
        echo "✓ instalado"
    else
        echo "~ disponible (npm install -g engram)"
    fi
    
    echo -n "📋 WORKSTYLE:    "
    if [ -f ~/.opencode/WORKSTYLE.md ]; then
        echo "✓ activo"
    else
        echo "✗ no configurado"
    fi
    
    echo -n "🛠 Skills:       "
    SKILLS=$(find ~/.config/opencode/skills -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
    echo "$SKILLS skills"
    
    echo -n "📁 Proyectos:    "
    if [ -d ~/projects ]; then
        echo "~ ~/projects/"
    else
        echo "no creado"
    fi
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# ═════════════════════════════════════════════════════════════════════════════
# FIN
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Listo! Empezá a usar tu AI configurado"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📝 Comandos:"
echo "   opencode           → Arrancar el agente"
echo "   mpw                → Ir a ~/projects"
echo "   mpw-status         → Ver estado"
echo ""
echo "🔗 Links útiles:"
echo "   Docs OpenCode:    https://opencode.ai/docs"
echo "   Nuestro repo:     https://github.com/maxpowerdev/maxpowerdev-workstyle"
echo ""