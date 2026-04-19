#!/bin/bash

# ═════════════════════════════════════════════════════════════════════════════
#  MAXPOWERDEV WORKSTYLE - SETUP PROFESIONAL COMPLETO
#  Tu AI coding assistant, tus reglas
# ═════════════════════════════════════════════════════════════════════════════

set -e

echo "🚀 MaxPowerDev WorkStyle - Setup Completo"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

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
section() { echo -e "${MAGENTA}▸${NC} $1"; }

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
# 1. CONFIGURACIÓN BÁSICA - Directorios y estructura
# ═════════════════════════════════════════════════════════════════════════════

echo ""
section "📁Creando estructura de directorios..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

mkdir -p ~/.config/opencode
mkdir -p ~/.opencode
mkdir -p ~/projects
mkdir -p ~/scripts

log "Directorios creados"

# ═════════════════════════════════════════════════════════════════════════════════════
# 2. INSTALAR OPENCODE - El agente principal
# ═════════════════════════════════════════════════════════════════════════════

echo ""
section "🤖Instalando OpenCode..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if command -v opencode &> /dev/null; then
    log "OpenCode ya instalado: $(opencode --version 2>/dev/null || echo 'ok')"
else
    if command -v brew &> /dev/null; then
        brew install opencode 2>/dev/null || warn "Ejecutá: brew install opencode"
    else
        warn "brew no está instalado"
        echo "   → https://brew.sh"
    fi
fi

# ═════════════════════════════════════════════════════════════════════════════
# 3. INSTALAR ENGRAM - Memoria persistente
# ═════════════════════════════════════════════════════════════════════════════

echo ""
section "🧠Configurando Engram (memoria persistente)..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if command -v npm &> /dev/null; then
    if command -v engram &> /dev/null; then
        log "Engram CLI ya instalado"
    else
        npm install -g engram-cli 2>/dev/null || info "Engram se puede instalar después"
    fi
else
    info "Node.js recomendado para Engram"
    echo "   → brew install node"
fi

# Verificar Engram
if [ -d "$HOME/.config/opencode" ]; then
    if [ -f "$HOME/.config/opencode/AGENTS.md" ] || [ -f "$HOME/opencode/WORKSTYLE.md" ]; then
        log "Memoria configurada"
    fi
fi

# ═════════════════════════════════════════════════════════════════════════════
# 4. WORKSTYLE - Tu guía de trabajo
# ═════════════════════════════════════════════════════════════════════════════

echo ""
section "📋Instalando WORKSTYLE (tu guía de trabajo)..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Descargar WORKSTYLE desde GitHub
WORKSTYLE_URL="https://raw.githubusercontent.com/maxpowerdev/maxpowerdev-workstyle/main/WORKSTYLE.md"
if curl -fsSL "$WORKSTYLE_URL" -o ~/.opencode/WORKSTYLE.md 2>/dev/null; then
    log "WORKSTYLE.md instalado en ~/.opencode/"
else
    # Si estamos en el repo local
    if [ -f "$(dirname "$0")/WORKSTYLE.md" ]; then
        cp "$(dirname "$0")/WORKSTYLE.md" ~/.opencode/WORKSTYLE.md
        log "WORKSTYLE.md instalado (local)"
    else
        warn "No se pudo descargar WORKSTYLE.md"
    fi
fi

# Crear AGENTS.md con configuración personalizada
cat > ~/.opencode/AGENTS.md << 'AGENTS'
# Mi Configuración de Agentes

## Instrucciones Principales
- SIEMPRE pedí approval antes de hacer cambios significativos
- Guardá decisiones en memoria (Engram) automáticamente
- Usá los skills disponibles del proyecto

## Preferencias
- Prefiero explicarme el "por qué" antes del código
- Si algo parece incorrecto, preguntá antes de asumir
- Guardá bugs corregidos y patrones nuevos

## Memoria (Engram)
- Save decisiones de arquitectura
- Save bugs corregidos con solución
- Save patrones que usamos
- NO preguntes si ya tenés contexto

## Skills a usar
- sdd-* para features nuevas
- judgment-day para reviews importantes
- skill-registry para registrar skills del proyecto
AGENTS

log "AGENTS.md configurado"

# ═════════════════════════════════════════════════════════════════════════════
# 5. SKILLS - Los skills del setup
# ═════════════════════════════════════════════════════════════════════════════

echo ""
section "🛠Skills disponibles en el sistema..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Ver skills existentes
mkdir -p ~/.config/opencode/skills

# Skills del repo (se pueden agregar manualmente)
SKILLS_REPO="maxpowerdev/maxpowerdev-workstyle"
info "Skills disponibles en: https://github.com/$SKILLS_REPO"

# Listado de skills populares para agregar
echo ""
echo "📦 Skills que podés agregar:"
echo ""
echo "   🟣 Framework & UI:"
echo "      • nextjs-15          - Next.js 15 App Router"
echo "      • react-19           - React 19 + Compiler"
echo "      • react-native       - Mobile apps"
echo "      • angular-core       - Angular signals"
echo "      • vue-3              - Vue 3 Composition API"
echo "      • tailwind-4         - CSS moderno"
echo ""
echo "   🔵 Backend & DB:"
echo "      • prisma             - ORM type-safe"
echo "      • supabase          - Firebase alternative"
echo "      • django-drf        - Django REST API"
echo "      • spring-boot-3      - Spring Boot 3"
echo "      • deno              - Runtime moderno"
echo ""
echo "   🟢 Testing & Quality:"
echo "      • playwright         - E2E testing"
echo "      • vitest            - Unit testing"
echo "      • pytest           - Python testing"
echo "      • go-testing       - Go testing"
echo ""
echo "   🟡 DevOps & Cloud:"
echo "      • github-actions    - CI/CD"
echo "      • gcp              - Google Cloud"
echo "      • docker           - Containers"
echo ""
echo "   🔴 AI & Automation:"
echo "      • ai-sdk-5          - Vercel AI SDK"
echo "      • mcp-builder      - Model Context Protocol"
echo "      • n8n              - Workflow automation"
echo ""

# ═════════════════════════════════════════════════════════════════════════════
# 6. REDUX TOOLKIT (RTK) - State management
# ═════════════════════════════════════════════════════════════════════════════

echo ""
section "⚛️Agregando Redux Toolkit..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Crear config para RTK
mkdir -p ~/.config/opencode/skills/@reduxjs

cat > ~/.config/opencode/skills/@reduxjs/SKILL.md << 'RTK'
# @reduxjs/toolkit - Redux Toolkit

## Cuándo usar
- React/Vue apps que necesitan global state
- Estado compartido entre muchos componentes
- Datos que persisten entre pantallas

## Patterns
- Use createSlice para reducer + actions
- Use createAsyncThunk para API calls
- Configure store con configureStore

## Ejemplo
\`\`\`js
import { createSlice, configureStore } from '@reduxjs/toolkit'

const counterSlice = createSlice({
  name: 'counter',
  initialState: { value: 0 },
  reducers: {
    increment: (state) => { state.value += 1 },
    decrement: (state) => { state.value -= 1 },
  }
})

export const { increment, decrement } = counterSlice.actions

export const store = configureStore({
  reducer: { counter: counterSlice.reducer }
})
\`\`\`

## Links
- Docs: https://redux-toolkit.js.org
- RTK Query: https://redux-toolkit.js.org/rtk-query
RTK

log "RTK skill agregado"

# ═════════════════════════════════════════════════════════════════════════════
# 7. CREAR ALIAS ÚTILES
# ═════════════════════════════════════════════════════════════════════════════

echo ""
section "⚡Creando aliases útiles..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

PROFILE_FILE="$HOME/.bashrc"
[ -f "$HOME/.zshrc" ] && PROFILE_FILE="$HOME/.zshrc"

# Agregar aliases si no existen
if ! grep -q "# MaxPowerDev WorkStyle" "$PROFILE_FILE" 2>/dev/null; then
    cat >> "$PROFILE_FILE" << 'ALIAS'

# ═════════════════════════════════════════════════════════════════════════════
# MaxPowerDev WorkStyle - Aliases
# ═════════════════════════════════════════════════════════════════════════════
alias mpw="cd ~/projects"
alias mpw-new="mkdir -p ~/projects/\${1:-new-project} && cd ~/projects/\${1:-new-project}"
alias mpw-skills="find ~/.config/opencode/skills -name SKILL.md 2>/dev/null | wc -l"
alias mpw-status='echo "=== MaxPowerDev WorkStyle ===" && echo "OpenCode: $(which opencode 2>/dev/null || echo installed)" && echo "Skills: $(find ~/.config/opencode/skills -name SKILL.md 2>/dev/null | wc -l | tr -d '"'"' '"'"')" && echo "Engram: $(which engram 2>/dev/null || echo available)"'
alias mpw-docs="open https://opencode.ai/docs"
alias mpw-repo="cd ~/projects/maxpowerdev-workstyle 2>/dev/null || echo '"'"'Descargá el repo: git clone github.com/maxpowerdev/maxpowerdev-workstyle ~/projects/maxpowerdev-workstyle'"'"'"
ALIAS
    log "Aliases creados en $PROFILE_FILE"
else
    info "Aliases ya existen"
fi

# ═════════════════════════════════════════════════════════════════════════════
# 8. CONFIGURAR BACKUP AUTOMÁTICO
# ═════════════════════════════════════════════════════════════════════════════

echo ""
section "💾Configurando backup automático..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Crear script de backup
BACKUP_SCRIPT=~/scripts/backup-workstyle.sh

cat > "$BACKUP_SCRIPT" << 'BKP'
#!/bin/bash
# Backup automático de WorkStyle
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR=~/backups/workstyle

mkdir -p "$BACKUP_DIR"

[ -f ~/.opencode/WORKSTYLE.md ] && cp ~/.opencode/WORKSTYLE.md "$BACKUP_DIR/workstyle_$DATE.md"
[ -f ~/.opencode/AGENTS.md ] && cp ~/.opencode/AGENTS.md "$BACKUP_DIR/agents_$DATE.md"

echo "Backup: $BACKUP_DIR/workstyle_$DATE.md"

# Mantener solo los últimos 10
ls -t "$BACKUP_DIR"/*.md 2>/dev/null | tail -n +11 | xargs -r rm 2>/dev/null || true
BKP

chmod +x "$BACKUP_SCRIPT"
log "Script de backup creado: $BACKUP_SCRIPT"

# ═════════════════════════════════════════════════════════════════════════════
# 9. CREAR PROYECTO BASE DE EJEMPLO
# ═════════════════════════════════════════════════════════════════════════════

echo ""
section "📂Creando proyecto de ejemplo..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

mkdir -p ~/projects
mkdir -p ~/projects/maxpowerdev-workstyle

cat > ~/projects/maxpowerdev-workstyle/README.md << 'README'
# MaxPowerDev WorkStyle - Proyecto Base

Tu nuevo proyecto configurado con WorkStyle!

## Comandos
\`\`\`bash
opencode              # Arrancar el agente
mpw-status            # Ver estado
mpw-skills            # Ver skills disponibles
\`\`\`

## Estructura
\`\`\`
projects/
├── maxpowerdev-workstyle/  ← Este repo
└── tus-proyectos/         ← Los tuyos
\`\`\`

## Links
- Docs: https://opencode.ai/docs
- Repo: https://github.com/maxpowerdev/maxpowerdev-workstyle
README

cat > ~/projects/maxpowerdev-workstyle/package.json << 'PKG'
{
  "name": "maxpowerdev-workstyle",
  "version": "1.0.0",
  "description": "Tu setup profesional de AI coding",
  "scripts": {
    "dev": "echo 'Arrancá con opencode'",
    "build": "echo 'Listo para deployar'"
  },
  "keywords": ["ai", "coding", "opencode", "workstyle"],
  "author": "MaxPowerDev",
  "license": "MIT"
}
PKG

log "Proyecto base creado en ~/projects/maxpowerdev-workstyle/"

# ═════════════════════════════════════════════════════════════════════════════
# 10. VERIFICACIÓN FINAL
# ═════════════════════════════════════════════════════════════════════════════

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ VERIFICACIÓN FINAL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo ""
echo "📊 ESTADO DEL SISTEMA:"
echo ""

echo -n "🤖 OpenCode:     "
if command -v opencode &> /dev/null; then
    echo -e "${GREEN}✓ instalado${NC}"
else
    echo -e "${YELLOW}✗ no instalado (brew install opencode)${NC}"
fi

echo -n "🧠 Engram:       "
if command -v engram &> /dev/null; then
    echo -e "${GREEN}✓ instalado${NC}"
else
    echo -e "${BLUE}~ npm install -g engram-cli${NC}"
fi

echo -n "⚛️ RTK:           "
[ -f ~/.config/opencode/skills/@reduxjs/SKILL.md ] && echo -e "${GREEN}✓ disponible${NC}" || echo "✗"

echo -n "📋 WORKSTYLE:    "
[ -f ~/.opencode/WORKSTYLE.md ] && echo -e "${GREEN}✓ activo${NC}" || echo "✗ no configurado"

echo -n "📋 AGENTS:      "
[ -f ~/.opencode/AGENTS.md ] && echo -e "${GREEN}✓ configurado${NC}" || echo "✗"

echo -n "🛠 Skills:       "
SKILLS_COUNT=$(find ~/.config/opencode/skills -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
echo "$SKILLS_COUNT skills"

echo -n "⚡ Aliases:      "
grep -q "# MaxPowerDev WorkStyle" "$PROFILE_FILE" 2>/dev/null && echo -e "${GREEN}✓ creados${NC}" || echo "✗"

echo -n "💾 Backup:       "
[ -f ~/scripts/backup-workstyle.sh ] && echo -e "${GREEN}✓ configurado${NC}" || echo "✗"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 INSTALACIÓN COMPLETA!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📝 PRÓXIMOS PASOS:"
echo ""
echo "  1. Reiniciá tu terminal (source ~/.bashrc o ~/.zshrc)"
echo "  2. Escribí 'mpw-status' para ver el estado"
echo "  3. Arrancá un proyecto nuevo con 'opencode'"
echo ""
echo "📚 Links útiles:"
echo "  • Docs OpenCode:      https://opencode.ai/docs"
echo "  • Repo WorkStyle:    https://github.com/maxpowerdev/maxpowerdev-workstyle"
echo "  • Engram:           https://engram.ai"
echo "  • Redux Toolkit:    https://redux-toolkit.js.org"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 LISTO PARA TRABAJAR!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"