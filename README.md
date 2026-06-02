# Landing de Proyecto Arquitectónico
### Kit generado con SoyLeo AI — soyleoai.com

---

## Qué contiene este repositorio

```
/
├── index.html           — Landing page interactiva lista para publicar
├── proyecto.json        — Datos del proyecto (editar aquí)
├── CLAUDE.md            — Instrucciones para Claude Code
├── README.md            — Este archivo
├── crear_landing.sh     — Script de automatización (1 comando = landing publicada)
├── .gitignore
├── agentes/             — Pipeline Multi-Agente (IA especializada)
│   ├── 1-analista.md    — Agente Analista de Información
│   ├── 2-articulador.md — Agente Articulador de Datos
│   ├── 3-disenador.md   — Agente Diseñador Premium (Frontend)
│   └── 4-tester.md      — Agente QA Tester (Validador)
└── assets/
    ├── video.mp4
    ├── planta3d.png
    ├── frente.png
    ├── cocina-comedor.png
    ├── habitacion.png
    └── baño.png
```

---

## Automatización: 1 Comando = Landing Publicada

### Requisitos previos del alumno

| Herramienta | Para qué se usa | Instalación |
|---|---|---|
| **Git** | Versionar y subir archivos | [git-scm.com](https://git-scm.com) |
| **GitHub CLI (`gh`)** | Crear repos y activar Pages desde terminal | [cli.github.com](https://cli.github.com) + `gh auth login` |
| **Claude Code** | IA que lee los renders/presupuestos y escribe el código | `npm install -g @anthropic-ai/claude-code` |
| **Cuenta GitHub** | Hostear la landing gratis en GitHub Pages | [github.com/signup](https://github.com/signup) |

> **No se necesitan MCPs ni configuraciones adicionales.**

### Ejecutar la automatización

Abrir Git Bash (o terminal compatible) y pegar:

```bash
curl -s https://raw.githubusercontent.com/Leoscd/presentacion-arquitectonica/main/crear_landing.sh | bash
```

El script pedirá:
1. **Nombre del proyecto** (ej: `torre-libertad`)
2. **Ruta a la carpeta** con los renders, video y presupuesto del alumno

Luego, automáticamente:
- Descarga este repositorio como plantilla
- Copia los assets del alumno
- Ejecuta el **Pipeline Multi-Agente** de IA (ver abajo)
- Crea un repositorio público en el GitHub del alumno
- Activa GitHub Pages
- Entrega la URL final lista para compartir con el cliente

---

## Pipeline Multi-Agente de IA

El script ejecuta **4 agentes especializados** en secuencia. Cada uno tiene un rol definido y un procedimiento operativo estándar (SOP):

### 🕵️ Agente 1: Analista de Información (`agentes/1-analista.md`)
- **Misión:** Escanear la carpeta `assets/` e inventariar qué información existe (imágenes, videos, presupuestos) y qué falta.
- **Output:** Genera `estado-proyecto.json` con el mapa de recursos disponibles.

### 🏗️ Agente 2: Articulador de Datos (`agentes/2-articulador.md`)
- **Misión:** Cruzar los datos del presupuesto con los espacios y renders del proyecto.
- **Output:** Actualiza `proyecto.json` con rubros, totales, superficies y asignación de imágenes a locales.

### ✨ Agente 3: Diseñador Premium (`agentes/3-disenador.md`)
- **Misión:** Inyectar los datos del JSON en `index.html` con diseño premium Dark Gold.
- **Funcionalidades que genera:**
  - Planimetría interactiva con marcadores clickeables
  - Galería de renders con scroll horizontal
  - Presupuesto con pestañas (Rubros / Resumen)
  - Sección de feedback del cliente

### 🛡️ Agente 4: QA Tester (`agentes/4-tester.md`)
- **Misión:** Verificar consistencia entre datos y visuales.
- **Validaciones:** Links de imágenes, sumas de presupuesto, coherencia arquitectónica, eliminación de placeholders.

---

## Personalizar para otro proyecto

1. Editar `proyecto.json` con los datos del nuevo proyecto
2. Reemplazar las imágenes en `assets/` con las del nuevo proyecto
3. Abrir Claude Code en esta carpeta y ejecutar:

```
Lee proyecto.json y regenera index.html con los nuevos datos.
```

4. Hacer commit y push. GitHub Pages se actualiza automáticamente.

---

## Créditos

Generado con **SoyLeo AI** — Sistema de documentación arquitectónica con IA
Arq. Leonardo Díaz | Tucumán, Argentina
[soyleoai.com](https://soyleoai.com) | [@soy.leo_ai](https://instagram.com/soy.leo_ai)
