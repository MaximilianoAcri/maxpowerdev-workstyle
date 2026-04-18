#!/bin/bash

# MaxPowerDev Work Style - Install Script

set -e

echo "🚀 Instalando MaxPowerDev Work Style..."

# Detectar SO
OS=$(uname -s)

# Crear directorio si no existe
mkdir -p ~/.opencode

# Copiar WORKSTYLE.md
cp "$(dirname "$0")/WORKSTYLE.md" ~/.opencode/WORKSTYLE.md

echo "✅ WORKSTYLE.md copiado a ~/.opencode/"

# Verificar que OpenCode esté instalado
if command -v opencode &> /dev/null; then
    VERSION=$(opencode --version 2>&1 | head -1)
    echo "✅ OpenCode instalado: $VERSION"
else
    echo "⚠️ OpenCode no está instalado"
    echo "   Installalo con: brew install opencode"
fi

# Verificar Git
if command -v git &> /dev/null; then
    echo "✅ Git instalado"
else
    echo "⚠️ Git no está instalado"
fi

echo ""
echo "🎉 Listo!"
echo ""
echo "Para verificar:"
echo "  cat ~/.opencode/WORKSTYLE.md"
echo ""
echo "Para más info: https://github.com/maxpowerdev/maxpowerdev-workstyle"