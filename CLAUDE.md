# CLAUDE.md — Kit Landing de Proyecto Arquitectonico (v2)
## por SoyLeo AI — Arq. Leonardo Diaz | soyleoai.com | @soy.leo_ai

---

## Para que sirve este kit

Este repositorio genera automaticamente una **landing page profesional de presentacion de proyecto arquitectonico** lista para publicar en GitHub Pages.

La **version 2** agrega un sistema de **showroom 3D inmersivo** con:
- Sistema de marca personalizable (3 presets + custom)
- Estructura de edificio multi-piso con vista explotada
- Tours 360° opcionales por ambiente (Pannellum)
- Gráfico de presupuesto donut interactivo
- Modal teatro para cada sector
- Features flags activables por proyecto

El arquitecto solo necesita:
1. Completar `proyecto.json` con sus datos (incluyendo `marca`, `edificio`, `sectores` y `features`)
2. Reemplazar las imagenes en `assets/`
3. Publicar en GitHub Pages

Claude Code lee este archivo y sabe exactamente que hacer en cada caso.

---

## Comandos disponibles

### Generar landing completa desde cero
```
Lee proyecto.json, lee CLAUDE.md y genera index.html con la landing completa del proyecto.
Usa el video como hero principal (autoplay, muted, loop, sin controles).
Mantene el diseno premium dark gold de la plantilla base.
Aplica la paleta de marca de proyecto.json.marca al bloque <style id="brand-vars">.
```

### Cambiar datos del proyecto
```
Actualiza proyecto.json con estos nuevos datos: [pegar datos]
Luego regenera index.html sin cambiar el diseno.
```

### Cambiar nombre o estudio
```
Cambia el nombre del proyecto a "[NOMBRE]" y el estudio a "[ESTUDIO]"
en proyecto.json y regenera index.html.
```

### Cambiar paleta de marca (nuevo v2)
```
Cambia el preset de marca a [dark-gold|light-marble|bauhaus-color|custom]
Si es custom, usar los colores: acento=[#hex], fondo=[#hex], texto=[#hex]
El Agente 3 va a inyectar la paleta al bloque <style id="brand-vars">.
El Agente 4 va a validar el contraste WCAG AA.
```

### Cambiar paleta de marca a custom
```
Personaliza los colores de la marca con:
- color_acento: #XXXXXX
- color_fondo: #XXXXXX
- color_texto: #XXXXXX
- fuente_titulo: [nombre de Google Font]
- fuente_cuerpo: [nombre de Google Font]
Si la fuente no esta en Google Fonts, usar fallback Cormorant Garamond + DM Mono.
```

### Agregar o quitar rubros del presupuesto
```
Agrega estos rubros al presupuesto en proyecto.json: [lista de rubros]
Recalcula el total y regenera la seccion de presupuesto en index.html.
```

### Agregar seccion de cronograma
```
Agrega una seccion de cronograma de obra a index.html usando los datos
de proyecto.json campo "cronograma". Mantene el estilo dark gold.
```

### Activar/desactivar features flags (nuevo v2)
```
Activa el feature [tour_360|exploded_view|modal_teatro|donut_presupuesto]
en proyecto.json.features. El Agente 4 validara que existan los assets necesarios.
```

### Agregar tour 360 a un sector (nuevo v2)
```
Para el sector [nombre], activa el tour 360 colocando la imagen
en assets/360/[nombre].jpg con ratio 2:1 (equirectangular).
El feature tour_360 se activara automaticamente.
```

### Preparar para GitHub Pages
```
Revisa index.html y verifica que todos los paths de assets sean relativos.
Genera el archivo README.md con instrucciones para publicar en GitHub Pages.
Verifica que el video este referenciado como assets/video.mp4
```

---

## Estructura del proyecto (v2)

```
landing-proyecto/
├── CLAUDE.md                  <- este archivo, instrucciones para Claude Code
├── proyecto.json              <- FUENTE DE VERDAD — editar aqui los datos (schema v2)
├── index.html                 <- generado/actualizado por Claude Code
├── README.md                  <- instrucciones GitHub Pages (generado)
└── assets/
    ├── video.mp4              <- video hero (reemplazar con video real)
    ├── logo.svg               <- NUEVO v2: logo del estudio (opcional)
    ├── favicon.ico            <- NUEVO v2: favicon (opcional)
    ├── planta3d.png           <- imagen principal / vista 3D del conjunto
    ├── pisos/                 <- NUEVO v2: un PNG por piso (para exploded view)
    │   ├── planta-baja.png
    │   ├── piso-1.png
    │   └── piso-2.png
    ├── sectores/              <- NUEVO v2: renders por sector (alternativa a raiz)
    │   ├── cocina-comedor.png
    │   ├── habitacion.png
    │   └── baño.png
    └── 360/                   <- NUEVO v2: fotos equirectangulares (tours opcionales)
        ├── cocina.jpg
        └── habitacion.jpg
```

**Compatibilidad:** los assets en raiz (sin subcarpeta) siguen funcionando, el Agente 1 los detecta y migra automaticamente al nuevo formato.

---

## Reglas de generacion (Claude debe seguir estas siempre)

**Diseno:**
- Fondo oscuro (#080808 por default), tipografia editorial serif + mono
- Acento dorado (#C9A84C por default) como color principal de marca — **modificable via proyecto.json.marca**
- Responsive mobile-first, sin frameworks externos
- Google Fonts: Cormorant Garamond + DM Mono (o las fuentes de la marca)

**Video hero:**
- Siempre es lo primero que se ve al cargar la pagina
- `autoplay muted loop playsinline`, sin controles visibles
- Overlay gradient oscuro para legibilidad del texto

**Presupuesto:**
- Tabla completa con todos los rubros de proyecto.json
- Cards de resumen lateral: total, materiales, MO, costo/m2, costo/depto
- Nota aclaratoria al pie: sin IVA, sin honorarios

**Marca (nuevo v2):**
- Las variables de marca se inyectan en `<style id="brand-vars">` dentro de `<head>`
- El `:root` del CSS principal actua como fallback con valores dark-gold
- 3 presets disponibles: `dark-gold`, `light-marble`, `bauhaus-color`
- Custom: el arquitecto define los colores directamente en `proyecto.json.marca`

**Assets:**
- Todos los paths deben ser RELATIVOS (assets/imagen.png, no /assets/)
- Esto es critico para que GitHub Pages funcione correctamente

**Performance:**
- HTML unico (sin CSS/JS externos salvo Google Fonts y Pannellum/CountUp opcionales via CDN)
- Sin dependencias npm ni bundlers
- El archivo index.html debe funcionar abriendolo directamente en un browser

**Features flags (nuevo v2):**
- Cada flag en `proyecto.json.features` se valida contra los assets disponibles (Agente 4)
- Si un flag esta `true` pero no hay assets, el Agente 4 lo cambia a `false` con warning
- Flags disponibles: `exploded_view`, `tour_360`, `donut_presupuesto`, `modal_teatro`, `cursor_custom`, `loader_marca`, `smooth_scroll`, `hero_video`

---

## Guia rapida — Publicar en GitHub Pages

### Paso 1: Crear repositorio
- Ir a github.com/new
- Nombre del repo: `landing-[nombre-proyecto]` (ej: `landing-casa-rogeris`)
- Visibilidad: Public (requerido para GitHub Pages gratis)

### Paso 2: Subir archivos
```bash
git init
git add .
git commit -m "Landing inicial"
git remote add origin https://github.com/[tu-usuario]/landing-[proyecto].git
git push -u origin main
```

### Paso 3: Activar GitHub Pages
- Ir al repo en GitHub
- Settings > Pages
- Source: Deploy from branch
- Branch: main / (root)
- Save

### Paso 4: URL publica
La landing queda disponible en:
`https://[tu-usuario].github.io/landing-[nombre-proyecto]/`

Esa URL la compartis con el cliente o la incluís en tu propuesta.

---

## proyecto.json — Estructura de referencia (v2)

```json
{
  "proyecto": {
    "nombre": "Casa Rogeris",
    "subtitulo": "Complejo 4 Departamentos — Steel Frame",
    "descripcion": "...",
    "arquitecto": "Arq. Leonardo Diaz",
    "estudio": "SoyLeo AI",
    "superficie_total": "193 m²",
    "ubicacion": "Tucuman, NOA",
    "año": "2025",
    "contacto": {
      "email": "...",
      "instagram": "...",
      "web": "..."
    }
  },

  "marca": {
    "preset": "dark-gold",
    "color_acento": "#C9A84C",
    "color_fondo": "#080808",
    "color_texto": "#cac6be",
    "color_acento_secundario": "#ede9e0",
    "fuente_titulo": "Cormorant Garamond",
    "fuente_cuerpo": "DM Mono",
    "logo": "assets/logo.svg"
  },

  "edificio": {
    "tipo": "mono_piso",
    "pisos": [
      {
        "id": "pb",
        "nombre": "Planta Baja",
        "imagen_planta": "assets/planta3d.png",
        "altura_metros": 2.8,
        "sectores": ["cocina", "bano"]
      }
    ]
  },

  "sectores": [
    {
      "id": "cocina",
      "nombre": "Cocina y Comedor",
      "piso_id": "pb",
      "hotspot": { "x": 63, "y": 63 },
      "render": "assets/cocina-comedor.png",
      "tour_360": "assets/360/cocina.jpg",
      "costo": 8500000,
      "superficie_m2": 22,
      "caracteristicas": [
        "Mobiliario en melamina texturizada",
        "Mesada de granito Negro Absoluto"
      ],
      "materiales": [
        { "nombre": "Granito Negro Absoluto", "proveedor": "Marmoleria X" }
      ]
    }
  ],

  "presupuesto": {
    "rubros": [
      {
        "numero": "01",
        "nombre": "Trabajos preparatorios",
        "materiales": 1050400,
        "mano_de_obra": 1575600,
        "total": 2626000,
        "incidencia": "2.0%"
      }
    ],
    "totales": {
      "materiales": 81453300,
      "mano_de_obra": 50133200,
      "total_obra": 131240000,
      "costo_m2": 680000,
      "costo_depto": 32810000
    },
    "nota": "Presupuesto global orientativo. No incluye honorarios ni IVA."
  },

  "features": {
    "exploded_view": true,
    "tour_360": true,
    "donut_presupuesto": true,
    "modal_teatro": true,
    "cursor_custom": true,
    "loader_marca": true,
    "smooth_scroll": true,
    "hero_video": true
  }
}
```

---

## Presets de marca disponibles

| Preset | Acento | Fondo | Texto | Titulo | Cuerpo | Ideal para |
|---|---|---|---|---|---|---|
| `dark-gold` | `#C9A84C` | `#080808` | `#cac6be` | Cormorant Garamond | DM Mono | Premium, lofts, residencias |
| `light-marble` | `#1a1a1a` | `#f5f3ef` | `#3a3a3a` | Playfair Display | Inter | Minimalismo, clinicas, oficinas |
| `bauhaus-color` | `#E63946` | `#FAF9F6` | `#1D3557` | Space Grotesk | IBM Plex Mono | Contemporaneo, urbano, joven |
| `custom` | (definido) | (definido) | (definido) | (Google Font) | (Google Font) | Branding del estudio |

---

## Personalizacion por arquitecto

Cuando un arquitecto de la comunidad use este kit, debe:

1. **Renombrar** `proyecto.json` datos con su proyecto
2. **Definir su marca** en el bloque `marca` (preset o colores custom)
3. **Reemplazar** los archivos en `assets/` con su propio video, logo, imagenes y opcionalmente fotos 360°
4. **Ejecutar** en Claude Code: `Lee proyecto.json y regenera index.html con mis datos`
5. **Publicar** en su propio GitHub con el nombre de su proyecto

Cada arquitecto genera una URL unica para cada cliente.

---

## Pipeline de Agentes v2

```
[Input: assets/, proyecto.json]
        |
        v
Agente 1 (Analista)      -> estado-proyecto.json
        |  (detecta marca, pisos, 360, genera flags)
        v
Agente 2 (Articulador)    -> proyecto.json (migrado a v2 si era v1)
        |  (mapea sectores, valida flags, prorratea presupuesto)
        v
Agente 3 (Disenador)      -> index.html actualizado
        |  (inyecta marca, genera UI desde JSON)
        v
Agente 4 (Tester)         -> reporte QA con WCAG, features, estructura
        |
        v
[Output: index.html listo para GitHub Pages]
```

Para ejecutar el pipeline en secuencia:
```bash
claude -p "$(cat agentes/1-analista.md)" > /dev/null
claude -p "$(cat agentes/2-articulador.md)" > /dev/null
claude -p "$(cat agentes/3-disenador.md)" > /dev/null
claude -p "$(cat agentes/4-tester.md)" > /dev/null
```

---

## Creditos

Generado con **SoyLeo AI** — Sistema de documentacion arquitectonica con IA
Arq. Leonardo Diaz | Tucuman, Argentina
soyleoai.com | @soy.leo_ai | soyleo.ai.arq@gmail.com
