# Landing de Proyecto Arquitectónico — v2 Showroom 3D
### Kit generado con SoyLeo AI — soyleoai.com

**Versión 2:** showroom 3D inmersivo con marca personalizable, vista explotada del edificio, tours 360° opcionales y gráfico de presupuesto interactivo.

---

## Qué contiene este repositorio

```
/
├── index.html           — Landing-showroom 3D lista para publicar
├── proyecto.json        — Datos del proyecto (schema v2: marca, edificio, sectores, features)
├── CLAUDE.md            — Instrucciones para Claude Code (v2)
├── README.md            — Este archivo
├── crear_landing.sh     — Script de automatización (1 comando = landing publicada)
├── .gitignore
├── agentes/             — Pipeline Multi-Agente (IA especializada)
│   ├── 1-analista.md    — Agente Analista (detecta marca, pisos, 360, features)
│   ├── 2-articulador.md — Agente Articulador (migra v1→v2, valida flags)
│   ├── 3-disenador.md   — Agente Diseñador (inyecta marca, genera UI)
│   └── 4-tester.md      — Agente QA Tester (valida WCAG, features, estructura)
└── assets/
    ├── video.mp4        — Hero autoplay
    ├── logo.svg         — Logo del estudio (opcional)
    ├── planta3d.png     — Vista isométrica general
    ├── pisos/           — Un PNG por piso (para vista explotada)
    ├── sectores/        — Renders por ambiente
    └── 360/             — Fotos equirectangulares para tours opcionales
```

---

## Novedades de la v2

- **Sistema de marca personalizable** — 3 presets (`dark-gold`, `light-marble`, `bauhaus-color`) + colores custom de cada estudio
- **Estructura de edificio** — Detección automática de mono-piso vs multi-piso, mapeo de sectores a pisos
- **Vista explotada** (próximamente Fase 3) — Scroll cinematográfico que separa los pisos del edificio en 3D
- **Tours 360° opcionales** — Si el arquitecto provee fotos equirectangulares, se activan tours navegables por ambiente
- **Gráfico de presupuesto donut** (próximamente Fase 4) — Visualización interactiva por rubro con conteo animado
- **Modal teatro** (próximamente Fase 2) — Experiencia full-screen al seleccionar un sector
- **Features flags** — Cada proyecto activa/desactiva las funcionalidades según sus assets disponibles
- **Accesibilidad WCAG AA** — Validación automática de contraste de marca por el Agente 4

---

## Sistema de marca personalizable

Cada arquitecto puede elegir la paleta visual de su landing-showroom. Hay 3 presets predefinidos y un modo custom.

| Preset | Acento | Fondo | Texto | Tipografía | Ideal para |
|---|---|---|---|---|---|
| `dark-gold` (default) | `#C9A84C` | `#080808` | `#cac6be` | Cormorant Garamond + DM Mono | Premium, lofts, residencias |
| `light-marble` | `#1a1a1a` | `#f5f3ef` | `#3a3a3a` | Playfair Display + Inter | Minimalismo, clínicas, oficinas |
| `bauhaus-color` | `#E63946` | `#FAF9F6` | `#1D3557` | Space Grotesk + IBM Plex Mono | Contemporáneo, urbano, joven |
| `custom` | (definido) | (definido) | (definido) | (Google Font) | Branding del estudio |

### Cómo cambiar de marca

Edita el bloque `marca` en `proyecto.json`:

```json
"marca": {
  "preset": "light-marble",
  "color_acento": "#1a1a1a",
  "color_fondo": "#f5f3ef",
  "color_texto": "#3a3a3a",
  "color_acento_secundario": "#8a7f6d",
  "fuente_titulo": "Playfair Display",
  "fuente_cuerpo": "Inter",
  "logo": "assets/logo.svg"
}
```

Si elegís `preset: "custom"`, los colores se toman literalmente del JSON. El Agente 4 valida que el contraste cumpla WCAG AA (ratio >= 4.5:1).

---

## Estructura de edificio

La v2 distingue entre:

- **mono_piso**: 1 planta (casas, locales comerciales). Vista estándar con hotspots.
- **multi_piso**: 2+ plantas (edificios, torres). Vista explotada al hacer scroll.
- **multi_unidad**: 1 planta con varias unidades repetidas (complejos, loteos).

Ejemplo de un edificio de 2 pisos:

```json
"edificio": {
  "tipo": "multi_piso",
  "pisos": [
    {
      "id": "pb",
      "nombre": "Planta Baja",
      "imagen_planta": "assets/pisos/planta-baja.png",
      "altura_metros": 2.8,
      "sectores": ["cocina", "bano-pb"]
    },
    {
      "id": "p1",
      "nombre": "1er Piso",
      "imagen_planta": "assets/pisos/piso-1.png",
      "altura_metros": 2.8,
      "sectores": ["habitacion"]
    }
  ]
}
```

Si no tenés imágenes separadas por piso, dejá solo `assets/planta3d.png` y la v2 lo trata como `mono_piso`.

---

## Features flags

Activá o desactivá las funcionalidades del showroom según los assets que tengas:

```json
"features": {
  "exploded_view": true,      // requiere 2+ PNGs en assets/pisos/
  "tour_360": true,           // requiere JPGs en assets/360/
  "donut_presupuesto": true,  // siempre disponible
  "modal_teatro": true,       // requiere 2+ sectores
  "cursor_custom": true,      // siempre disponible
  "loader_marca": true,       // siempre disponible
  "smooth_scroll": true,      // siempre disponible
  "hero_video": true          // requiere assets/video.mp4
}
```

El **Agente 4 (QA Tester)** valida que cada flag `true` tenga los assets necesarios. Si falta algo, el flag se cambia a `false` automáticamente con un warning en el reporte.

---

## Tours 360° (opcional)

Para activar tours inmersivos por ambiente, proveé fotos equirectangulares (ratio 2:1).

**De dónde salen las fotos 360°:**
| Caso | Cómo obtenerla | Costo |
|---|---|---|
| Proyecto construido | Cámara 360° (Insta360 X3) o app Google Street View del celular | $0–500 |
| Solo render | Lumion / D5 / V-Ray / Enscape / Twinmotion exportan en modo "Panorama 360°" | $0 |
| Sin nada | Skybox AI de Blockade Labs (gratis, genera 360° desde prompt o imagen) | $0 |

**Colocá las fotos en** `assets/360/[nombre-sin-espacios].jpg` y el tour se activa automáticamente en el modal del sector correspondiente.

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
curl -s https://raw.githubusercontent.com/Leoscd/presentacion-arquitectonica-v2/main/crear_landing.sh | bash
```

El script pedirá:
1. **Nombre del proyecto** (ej: `torre-libertad`)
2. **Ruta a la carpeta** con los renders, video y presupuesto del alumno
3. **Preset de marca** (opcional: `dark-gold`, `light-marble`, `bauhaus-color`, `custom`)
4. **Cantidad de pisos** (1 = casa simple, 2+ = exploded view)
5. **Tiene fotos 360°** (sí / no)

Luego, automáticamente:
- Descarga este repositorio como plantilla
- Copia los assets del alumno
- Ejecuta el **Pipeline Multi-Agente** de IA (ver abajo)
- Crea un repositorio público en el GitHub del alumno
- Activa GitHub Pages
- Entrega la URL final lista para compartir con el cliente

---

## Pipeline Multi-Agente de IA (v2)

El script ejecuta **4 agentes especializados** en secuencia. Cada uno tiene un rol definido y un procedimiento operativo estándar (SOP):

### 🕵️ Agente 1: Analista de Información (`agentes/1-analista.md`)
- **Misión:** Escanear la carpeta `assets/` y sus subcarpetas; inventariar imágenes, video, planos por piso, fotos 360° y logo
- **Novedades v2:** Detecta estructura del edificio (mono/multi-piso), presencia de assets 360 y branding
- **Output:** Genera `estado-proyecto.json` con flags de features según assets disponibles

### 🏗️ Agente 2: Articulador de Datos (`agentes/2-articulador.md`)
- **Misión:** Transformar el inventario en un `proyecto.json` coherente
- **Novedades v2:** Migra automáticamente el schema v1 al v2, valida features flags vs assets, prorratea presupuesto a sectores
- **Output:** `proyecto.json` actualizado con bloques `marca`, `edificio`, `sectores` y `features`

### ✨ Agente 3: Diseñador Premium (`agentes/3-disenador.md`)
- **Misión:** Inyectar los datos del JSON en `index.html` con diseño premium
- **Novedades v2:** Inyecta variables de marca al bloque `<style id="brand-vars">`, resuelve los 3 presets, valida fuentes de Google Fonts
- **Output:** `index.html` con la paleta del arquitecto aplicada

### 🛡️ Agente 4: QA Tester (`agentes/4-tester.md`)
- **Misión:** Verificar consistencia entre datos y visuales
- **Novedades v2:** Valida contraste WCAG AA, valida features flags, valida estructura de edificio y de sectores
- **Output:** Reporte final con checks visuales, financieros, de accesibilidad y de estructura

---

## Personalizar para otro proyecto

1. Editar `proyecto.json` con los datos del nuevo proyecto (incluyendo `marca`, `edificio`, `sectores` y `features`)
2. Reemplazar las imágenes en `assets/` con las del nuevo proyecto
3. Abrir Claude Code en esta carpeta y ejecutar:

```
Lee proyecto.json y regenera index.html con los nuevos datos.
```

4. Hacer commit y push. GitHub Pages se actualiza automáticamente.

---

## Roadmap de implementación

| Fase | Entregable | Estado |
|---|---|---|
| **Fase 1** | Schema v2 + sistema de marca + 3 presets | ✅ Completada |
| **Fase 2** | Refactor estructural (loader, cursor, modal teatro, smooth scroll) | Próximamente |
| **Fase 3** | Escena 3D con CSS transforms + GSAP + vista explotada | Próximamente |
| **Fase 4** | Gráfico donut del presupuesto + CountUp animado | Próximamente |
| **Fase 5** | Tour 360 con Pannellum + Agente 5 Director 3D | Próximamente |
| **Fase 6** | QA con Casa Rogeris + ASSETS_GUIDE.md + demo | Próximamente |

---

## Créditos

Generado con **SoyLeo AI** — Sistema de documentación arquitectónica con IA
Arq. Leonardo Díaz | Tucumán, Argentina
[soyleoai.com](https://soyleoai.com) | [@soy.leo_ai](https://instagram.com/soy.leo_ai)
