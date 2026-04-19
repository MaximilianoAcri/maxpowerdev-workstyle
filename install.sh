#!/bin/bash

# ═════════════════════════════════════════════════════════════════════════════
#  MAXPOWERDEV COMPLETE SETUP - TODO EL ECOSISTEMA
# ═════════════════════════════════════════════════════════════════════════════

set -e

echo "🚀 MaxPowerDev Complete Setup"
echo "======================================"
echo ""

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}✓${NC} $1"; }
info() { echo -e "${BLUE}ℹ${NC} $1"; }

# ═════════════════════════════════════════════════════════════════════════════
# MENÚ PRINCIPAL
# ═════════════════════════════════════════════════════════════════════════════

echo "Seleccioná tu instalación:"
echo ""
echo "1) BÁSICO - Solo WORKSTYLE (recomendado para empezar)"
echo "2) COMPLETO - Gentle-AI + Skills + Todo"
echo "3) ACTUALIZAR - Actualizar instalación existente"
echo ""

read -p "Opción [1-3]: " option

case $option in
    1) install_basic ;;
    2) install_complete ;;
    3) install_update ;;
    *) install_basic ;;
esac

# ═════════════════════════════════════════════════════════════════════════════
# INSTALACIÓN BÁSICA
# ═════════════════════════════════════════════════════════════════════════════

install_basic() {
    echo ""
    info "Instalando versión básica..."
    
    mkdir -p ~/.opencode
    mkdir -p ~/.config/opencode
    
    # Copiar WORKSTYLE
    cp "$(dirname "$0")/WORKSTYLE.md" ~/.opencode/WORKSTYLE.md
    
    log "WORKSTYLE.md instalado en ~/.opencode/"
    
    # Verificar OpenCode
    if command -v opencode &> /dev/null; then
        log "OpenCode instalado: $(opencode --version)"
    else
        info "OpenCode no está instalado"
        echo "   brew install opencode"
    fi
}

# ═════════════════════════════════════════════════════════════════════════════
# INSTALACIÓN COMPLETA
# ═════════════════════════════════════════════════════════════════════════════

install_complete() {
    echo ""
    info "Instalando versión COMPLETA con Gentle-AI..."
    
    # Primero lo básico
    install_basic
    
    echo ""
    info "Instalando Gentle-AI..."
    
    # Instalar Gentle-AI
    if command -v brew &> /dev/null; then
        if ! brew tap | grep -q "Gentleman-Programming/homebrew-tap"; then
            brew tap Gentleman-Programming/homebrew-tap
        fi
        brew install gentle-ai
        log "Gentle-AI instalado"
        
        # Configurar
        echo ""
        info "Configurando Gentle-AI..."
        gentle-ai install --profile opencode 2>/dev/null || true
        gentle-ai sync 2>/dev/null || true
        
        log "Gentle-AI configurado"
    else
        echo "brew no está instalado. Instalalo desde https://brew.sh"
    fi
    
    # Instalar Engram CLI
    if command -v engram &> /dev/null; then
        log "Engram ya instalado"
    else
        info "Engram CLI no está instalado"
        echo "   npm install -g engram-cli"
    fi
    
    # Crear estructura de proyectos
    mkdir -p ~/projects
    
    # Agregar alias
    echo 'alias mpw="cd ~/projects"' >> ~/.bashrc
    echo 'alias mpw-status="echo OpenCode: && opencode --version && echo Skills: && find ~/.config/opencode/skills -name SKILL.md | wc -l"' >> ~/.bashrc
    
    log "Alias creados"
}

# ═════════════════════════════════════════════════════════════════════════════
# ACTUALIZAR
# ═════════════════════════════════════════════════════════════════════════════

install_update() {
    echo ""
    info "Actualizando..."
    
    # Actualizar WORKSTYLE
    cp "$(dirname "$0")/WORKSTYLE.md" ~/.opencode/WORKSTYLE.md
    log "WORKSTYLE actualizado"
    
    # Actualizar skills
    if command -v gentle-ai &> /dev/null; then
        gentle-ai sync
        log "Skills actualizados"
    fi
    
    # Actualizar Engram
    if command -v engram &> /dev/null; then
        engram sync 2>/dev/null || true
        log "Engram sincronizado"
    fi
}

# ═════════════════════════════════════════════════════════════════════════════
# FIN
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "======================================"
echo "🎉 Instalación completa!"
echo "======================================"
echo ""
echo "Comandos útiles:"
echo "  opencode           - Arrancar OpenCode"
echo "  gentle-ai          - Gentle-AI CLI"
echo "  engram projects    - Ver proyectos con memoria"
echo "  mpw               - Ir a ~/projects"
echo "  mpw-status        - Ver estado"
echo ""
echo "Links:"
echo "  Docs: https://opencode.ai/docs"
echo "  Gentle-AI: https://github.com/Gentleman-Programming/gentle-ai"
echo "  Nuestro setup: https://github.com/maxpowerdev/maxpowerdev-workstyle"
echo ""