#!/bin/bash

# ═════════════════════════════════════════════════════════════════════════════
#  MAXPOWERDEV COMPLETE SETUP - TODO EL ECOSISTEMA INSTALADO
# ═════════════════════════════════════════════════════════════════════════════════════

set -e

echo "🚀 MaxPowerDev Complete Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Función para mostrar mensajes
log() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
info() { echo -e "${BLUE}ℹ${NC} $1"; }

# Detectar SO
detect_os() {
    case "$(uname -s)" in
        Linux*) echo "linux";;
        Darwin*) echo "macos";;
        MINGW*|MSYS*|CYGWIN*) echo "windows";;
        *) echo "unknown";;
    esac
}

OS=$(detect_os)
log "Sistema detectado: $OS"

# ═════════════════════════════════════════════════════════════════════════════
# 1. CONFIGURACIÓN BÁSICA
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 CONFIGURACIÓN BÁSICA"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Crear directorios necesarios
mkdir -p ~/.config/opencode
mkdir -p ~/.opencode
mkdir -p ~/projects

log "Directorios creados"

# ═════════════════════════════════════════════════════════════════════════════
# 2. INSTALAR OPENCODE
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🤖 INSTALANDO OPENCODE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if command -v opencode &> /dev/null; then
    info "OpenCode ya instalado: $(opencode --version)"
else
    if [ "$OS" = "macos" ]; then
        brew install opencode
    elif [ "$OS" = "linux" ]; then
        brew install opencode
    fi
    log "OpenCode instalado"
fi

# ═════════════════════════════════════════════════════════════════════════════
# 3. INSTALAR GENTLE-AI (OPCIONAL PERO RECOMENDADO)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧠 INSTALANDO GENTLE-AI (Opcional)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

read -p "Querés instalar Gentle-AI para el ecosistema completo? [s/N]: " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Ss]$ ]]; then
    if command -v gentle-ai &> /dev/null; then
        info "Gentle-AI ya instalado"
    else
        if [ "$OS" = "macos" ] || [ "$OS" = "linux" ]; then
            brew tap Gentleman-Programming/homebrew-tap
            brew install gentle-ai
        fi
        log "Gentle-AI instalado"
    fi
    
    # Configurar perfiles
    log "Configurando perfiles..."
    gentle-ai install --profile opencode 2>/dev/null || true
    
    # Configurar Engram (memoria distribuida)
    log "Configurando Engram sync..."
    engram config set sync.enabled true 2>/dev/null || true
fi

# ═════════════════════════════════════════════════════════════════════════════
# 4. WORKSTYLE (NUESTRA CONFIG)
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 INSTALANDO WORKSTYLE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Descargar WORKSTYLE desde GitHub
WORKSTYLE_URL="https://raw.githubusercontent.com/maxpowerdev/maxpowerdev-workstyle/main/WORKSTYLE.md"
curl -fsSL "$WORKSTYLE_URL" -o ~/.opencode/WORKSTYLE.md

log "WORKSTYLE.md instalado en ~/.opencode/"

# Instalar skills de GitHub si existen
mkdir -p ~/.config/opencode/skills
SKILLS_REPO="maxpowerdev/maxpowerdev-workstyle"
info "Podés agregar skills desde: https://github.com/$SKILLS_REPO"

# ═════════════════════════════════════════════════════════════════════════════
# 5. CREAR ALIAS Y SHORTCUTS
# ══════════════════════════════════════════════��══════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚡ CREANDO ALIAS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Agregar al .bashrc o .zshrc
PROFILE_FILE="$HOME/.bashrc"
[ -f "$HOME/.zshrc" ] && PROFILE_FILE="$HOME/.zshrc"

# Alias útiles
ALIASES='
# MaxPowerDev Aliases
alias mpw="cd ~/projects"
alias mpw-new="cd ~/projects && mkdir new-project"
alias mpw-skills="find ~/.config/opencode/skills -name SKILL.md | wc -l"
alias mpw-status="echo \"=== MaxPowerDev Status ===\" && opencode --version && echo \"=== Skills ===\" && find ~/.config/opencode/skills -name SKILL.md | wc -l"
alias mpw-update="cd ~/projects/maxpowerdev-workstyle && git pull"
'

# Agregar si no existen
if ! grep -q "# MaxPowerDev Aliases" "$PROFILE_FILE" 2>/dev/null; then
    echo "" >> "$PROFILE_FILE"
    echo "$ALIASES" >> "$PROFILE_FILE"
    log "Alias creados en $PROFILE_FILE"
fi

# ═════════════════════════════════════════════════════════════════════════════
# 6. CONFIGURAR BACKUP AUTOMÁTICO
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💾 CONFIGURANDO BACKUP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Crear script de backup
mkdir -p ~/scripts
BACKUP_SCRIPT=~/scripts/backup-opencode.sh

cat > "$BACKUP_SCRIPT" << 'BKP'
#!/bin/bash
# Backup automático de configuración OpenCode
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR=~/backups/opencode

mkdir -p "$BACKUP_DIR"
cp -r ~/.config/opencode "$BACKUP_DIR/config_$DATE"
cp -r ~/.opencode "$BACKUP_DIR/opencode_$DATE"

echo "Backup creado: $BACKUP_DIR/config_$DATE"
# Mantener solo los últimos 5
ls -t "$BACKUP_DIR" | tail -n +6 | xargs -r rm -rf
BKP

chmod +x "$BACKUP_SCRIPT"
log "Script de backup creado: $BACKUP_SCRIPT"

# Agregar al crontab (cada domingo a las 3am)
(crontab -l 2>/dev/null | grep -v "backup-opencode"; echo "0 3 * * 0 ~/scripts/backup-opencode.sh") | crontab -
log "Backup automático configurado (domingos 3am)"

# ═════════════════════════════════════════════════════════════════════════════
# 7. VERIFICACIÓN FINAL
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━��━��━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ VERIFICACIÓN FINAL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo ""
echo "📊 ESTADO DEL SISTEMA:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo -n "🤖 OpenCode: "
command -v opencode &> /dev/null && opencode --version || echo "no instalado"

echo -n "🧠 Gentle-AI: "
command -v gentle-ai &> /dev/null && gentle-ai --version || echo "no instalado"

echo -n "📋 WORKSTYLE: "
[ -f ~/.opencode/WORKSTYLE.md ] && echo "✓ instalado" || echo "no instalado"

echo -n "🛠 Skills: "
find ~/.config/opencode/skills -name SKILL.md 2>/dev/null | wc -l | tr -d '\n'
echo " skills"

echo -n "💾 Backup: "
[ -f ~/scripts/backup-opencode.sh ] && echo "✓ configurado" || echo "no configurado"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 INSTALACIÓN COMPLETA!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📝 PRÓXIMOS PASOS:"
echo ""
echo "  1. Reiniciá tu terminal"
echo "  2. Escribí 'mpw-status' para ver el estado"
echo "  3. Arrancá un proyecto nuevo y_USá OpenCode"
echo ""
echo "📚 Links útiles:"
echo "  • Docs: https://opencode.ai/docs"
echo "  • Gentle-AI: https://github.com/Gentleman-Programming/gentle-ai"
echo "  • Nuestro repo: https://github.com/maxpowerdev/maxpowerdev-workstyle"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 8. CREAR PROYECTO BASE
echo ""
read -p "Querés que cree un proyecto base en ~/projects/ ? [s/N]: " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Ss]$ ]]; then
    mkdir -p ~/projects
    cd ~/projects
    mkdir -p new-project
    cd new-project
    echo "# Mi Nuevo Proyecto" > README.md
    echo "Proyecto vacío - agregá lo que necesites" >> README.md
    log "Proyecto creado en: ~/projects/new-project/"
fi

echo ""
echo "🎯 Listo para usar! Escribí 'opencode' para arrancar."