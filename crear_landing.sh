#!/bin/bash

# ==============================================================================
# SoyLeo AI - Automatización de Landing Page de Arquitectura
# Este script crea un repositorio, genera la landing con Claude y publica en GitHub Pages
# ==============================================================================

echo -e "\n============================================="
echo -e "🚀 SoyLeo AI: Generador de Landing Architect"
echo -e "=============================================\n"

# 1. Validar herramientas requeridas
command -v git >/dev/null 2>&1 || { echo >&2 "❌ Error: 'git' no está instalado. Instalalo primero."; exit 1; }
command -v gh >/dev/null 2>&1 || { echo >&2 "❌ Error: 'gh' (GitHub CLI) no está instalado. Instalalo primero."; exit 1; }
command -v claude >/dev/null 2>&1 || { echo >&2 "❌ Error: 'claude' (Claude Code) no está instalado. Instalalo primero."; exit 1; }

# Validar login de GitHub
if ! gh auth status &>/dev/null; then
    echo "❌ Error: No estás logueado en GitHub CLI."
    echo "Ejecuta 'gh auth login' antes de correr este script."
    exit 1
fi

GITHUB_USER=$(gh api user -q ".login")
echo "✅ Logueado en GitHub como: $GITHUB_USER"

# 2. Pedir datos al alumno
echo -e "\n📝 Configuracion del nuevo proyecto:"
read -p "Nombre del Proyecto (ej: mi-nuevo-edificio): " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
    echo "❌ El nombre no puede estar vacío."
    exit 1
fi

PROJECT_NAME_SLUG=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr -s ' ' '-')

read -p "Ruta a la carpeta con tus archivos (renders, videos, presupuestos): " ASSETS_PATH

# Expandir tilde a home si es necesario
ASSETS_PATH="${ASSETS_PATH/#\~/$HOME}"

if [ ! -d "$ASSETS_PATH" ]; then
    echo "❌ La carpeta $ASSETS_PATH no existe."
    exit 1
fi

PROJECT_FOLDER="landing-$PROJECT_NAME_SLUG"

echo -e "\n⏳ Creando proyecto en: ./$PROJECT_FOLDER"

# 3. Descargar el Template Base
echo -e "\n⏳ Descargando la plantilla maestra de Arquitectura (SoyLeo AI)..."
# Clonamos el repositorio oficial base para el alumno
git clone https://github.com/Leoscd/presentacion-arquitectonica.git "$PROJECT_FOLDER"

if [ ! -d "$PROJECT_FOLDER" ]; then
    echo "❌ Error al descargar el repositorio. Verifica tu conexión a internet."
    exit 1
fi

cd "$PROJECT_FOLDER" || exit 1

# Limpiar git del template para arrancar un repositorio limpio
rm -rf .git
rm -f crear_landing.sh # Nos removemos a nosotros mismos del nuevo repo

# 4. Copiar los archivos del alumno a assets/
echo "📂 Copiando tus documentos e imágenes..."
rm -rf assets/*
mkdir -p assets
cp -R "$ASSETS_PATH/"* assets/

# 5. Pipeline Multi-Agente IA
echo -e "\n🤖 Ejecutando Pipeline Multi-Agente de Arquitectura..."
echo "Los Agentes analizarán y procesarán los datos. Esto llevará unos minutos..."

echo "   -> 🕵️ Ejecutando Agente Analista (Relevamiento de Datos)..."
# Invocando al agente y pasándole el archivo de instrucciones (requiere soporte del CLI -p)
# Usaremos un prompt que lee el contenido del markdown de instrucciones.
claude -p "$(cat agentes/1-analista.md)" > /dev/null

echo "   -> 🏗️ Ejecutando Agente Articulador (Mapeo de Presupuestos a JSON)..."
claude -p "$(cat agentes/2-articulador.md)" > /dev/null

echo "   -> ✨ Ejecutando Agente Diseñador Premium (Frontend & UI)..."
claude -p "$(cat agentes/3-disenador.md)" > /dev/null

echo "   -> 🛡️ Ejecutando Agente Tester (QA Data Matching)..."
claude -p "$(cat agentes/4-tester.md)" > /dev/null

echo "✅ Pipeline IA completado. Landing ensamblada con nivel Premium."

# 6. Inicializar Git y subir a GitHub
echo -e "\n🌐 Subiendo el proyecto a GitHub..."
git init
git add .
git commit -m "🚀 Landing de arquitectura autogenerada via SoyLeo AI"
git branch -M main

# Crear repo público (sin confirmacion manual)
gh repo create "$PROJECT_NAME_SLUG" --public --source=. --remote=origin --push

# 7. Activar GitHub Pages automáticamente
echo -e "\n⚙️ Activando GitHub Pages para este repositorio..."

# Utilizamos la API de GitHub CLI para solicitar la creación del site en la rama main path /
gh api "repos/$GITHUB_USER/$PROJECT_NAME_SLUG/pages" -X POST -f source[branch]=main -f source[path]="/" >/dev/null 2>&1 || {
    echo "⚠️ Nota: Github Pages podría ya estar en proceso o hubo un pequeño problema con la API," 
    echo "pero puedes verificar en los Settings de tu repositorio."
}

# 8. Entregar URL al alumno
URL="https://$GITHUB_USER.github.io/$PROJECT_NAME_SLUG/"

echo -e "\n============================================="
echo -e "🎉 ¡PROYECTO PUBLICADO EXITOSAMENTE! 🎉"
echo -e "============================================="
echo -e "Tu repositorio : https://github.com/$GITHUB_USER/$PROJECT_NAME_SLUG"
echo -e "Tu Landing Page: $URL"
echo -e "\n(Nota: GitHub Pages puede tardar 1 o 2 minutos en poner la web en vivo. ¡Paciencia!)"
echo -e "=============================================\n"
