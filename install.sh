#!/bin/bash

# ═════════════════════════════════════════════════════════════════════════════
#  MAXPOWERDEV WORKSTYLE - Tu AI labura solo
#  10+ AI Agents + Memoria + 100+ Skills
# ═════════════════════════════════════════════════════════════════════════════

set -e

echo "🚀 MaxPowerDev WorkStyle"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🤖 Tu AI labura solo. Memoria automática."
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

# ═════════════════════════════════════════════════════════════════════════════════════
# MENÚ PRINCIPAL
# ═════════════════════════════════════════════════════════════════════════════

echo "¿Qué querés instalar?"
echo ""
echo "  1) 🟢 BÁSICO      - Tu guía de trabajo (recomendado)"
echo "  2) 🟣 COMPLETO    - Todo el ecosistema (memoria + skills + Gentle-AI)"
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

# ═════════════════════════════════════════════════════════════════════════════
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
        log "WORKSTYLE.md instalado"
    else
        if [ -f "$(dirname "$0")/WORKSTYLE.md" ]; then
            cp "$(dirname "$0")/WORKSTYLE.md" ~/.opencode/WORKSTYLE.md
            log "WORKSTYLE.md instalado (local)"
        fi
    fi
    
    echo ""
    info "AI Agents soportados:"
    echo "   • Claude Code     • OpenCode      • Gemini CLI"
    echo "   • Cursor        • Windsurf      • Codex"
    echo "   • VS Copilot    • Kiro IDE     • Qwen"
    echo "   • Antigravity"
    
    show_status
}

# ═════════════════════════════════════════════════════════════════════════════════════
# INSTALACIÓN COMPLETA (Con Gentle-AI ecosystem)
# ═════════════════════════════════════════════════════════════════════════════

install_complete() {
    echo ""
    info "Instalando versión COMPLETA..."
    echo ""
    
    # Lo básico primero
    install_basic
    
    echo ""
    info "Instalando ecosistema Gentle-AI..."
    
    # Instalar Gentle-AI CLI
    if command -v brew &> /dev/null; then
        if ! brew tap | grep -q "Gentleman-Programming/homebrew-tap"; then
            brew tap Gentleman-Programming/homebrew-tap
        fi
        brew install gentle-ai 2>/dev/null || warn "Error instalando gentle-ai"
    fi
    
    # Configurar
    if command -v gentle-ai &> /dev/null; then
        log "Gentle-AI instalado"
        gentle-ai install --profile opencode 2>/dev/null || true
        gentle-ai sync 2>/dev/null || true
    else
        echo ""
        info "Para instalar Gentle-AI manualmente:"
        echo "   brew tap Gentleman-Programming/homebrew-tap"
        echo "   brew install gentle-ai"
    fi
    
    # Instalar Engram
    if command -v npm &> /dev/null; then
        npm install -g engram-cli 2>/dev/null || true
    fi
    
    # Crear estructura
    mkdir -p ~/projects
    
    show_status
}

# ═════════════════════════════════════════════════════════════════════════════
# ACTUALIZAR
# ═════════════════════════════════════════════════════════════════════

install_update() {
    echo ""
    info "Actualizando WorkStyle..."
    
    WORKSTYLE_URL="https://raw.githubusercontent.com/maxpowerdev/maxpowerdev-workstyle/main/WORKSTYLE.md"
    curl -fsSL "$WORKSTYLE_URL" -o ~/.opencode/WORKSTYLE.md 2>/dev/null && log "WORKSTYLE actualizado"
    
    if command -v gentle-ai &> /dev/null; then
        gentle-ai sync 2>/dev/null || true
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
    if command -v opencode &> /dev/null; then echo "✓"; else echo "✗"; fi
    
    echo -n "🧠 Engram:       "
    if command -v engram &> /dev/null; then echo "✓"; else echo "available"; fi
    
    echo -n "💜 Gentle-AI:   "
    if command -v gentle-ai &> /dev/null; then echo "✓"; else echo "available"; fi
    
    echo -n "📋 WORKSTYLE:    "
    [ -f ~/.opencode/WORKSTYLE.md ] && echo "✓" || echo "✗"
    
    echo -n "🛠 Skills:       "
    find ~/.config/opencode/skills -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' '
    echo " skills"
    
    echo ""
}

# ═════════════════════════════════════════════════════════════════════════════
# FIN
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Listo! Tu AI está listo para laburar"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📝 Arrancá con:"
echo "   opencode              → Tu agente"
echo "   gentle-ai             → Gentle-AI CLI"
echo ""
echo "🔗 Links:"
echo "   Gentle-AI:   https://github.com/Gentleman-Programming/gentle-ai"
echo "   Gentle-Skills: https://github.com/Gentleman-Programming/Gentleman-Skills"
echo "   Docs:        https://opencode.ai/docs"
echo ""