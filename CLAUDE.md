# CLAUDE.md — Kit Landing de Proyecto Arquitectonico
## por SoyLeo AI — Arq. Leonardo Diaz | soyleoai.com | @soy.leo_ai

---

## Para que sirve este kit

Este repositorio genera automaticamente una **landing page profesional de presentacion de proyecto arquitectonico** lista para publicar en GitHub Pages.

El arquitecto solo necesita:
1. Completar `proyecto.json` con sus datos
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

### Agregar o quitar rubros del presupuesto
```
Agrega estos rubros al presupuesto en proyecto.json: [lista de rubros]
Recalcula el total y regenera la seccion de presupuesto en index.html.
```

### Cambiar paleta de colores
```
Cambia el color de acento de oro (#C9A84C) a [nuevo color HEX]
en las variables CSS de index.html. Mantene el resto del diseno.
```

### Agregar seccion de cronograma
```
Agrega una seccion de cronograma de obra a index.html usando los datos
de proyecto.json campo "cronograma". Mantene el estilo dark gold.
```

### Preparar para GitHub Pages
```
Revisa index.html y verifica que todos los paths de assets sean relativos.
Genera el archivo README.md con instrucciones para publicar en GitHub Pages.
Verifica que el video este referenciado como assets/video.mp4
```

---

## Estructura del proyecto

```
landing-proyecto/
├── CLAUDE.md              <- este archivo, instrucciones para Claude Code
├── proyecto.json          <- FUENTE DE VERDAD — editar aqui los datos
├── index.html             <- generado/actualizado por Claude Code
├── README.md              <- instrucciones GitHub Pages (generado)
└── assets/
    ├── video.mp4          <- video hero (reemplazar con video real)
    ├── planta3d.png       <- imagen principal / vista 3D del conjunto
    ├── cocina-comedor.png <- render interior 1
    ├── habitacion.png     <- render interior 2
    └── baño.png           <- render interior 3
```

---

## Reglas de generacion (Claude debe seguir estas siempre)

**Diseno:**
- Fondo oscuro (#080808), tipografia editorial serif + mono
- Acento dorado (#C9A84C) como color principal de marca
- Responsive mobile-first, sin frameworks externos
- Google Fonts: Cormorant Garamond + DM Mono

**Video hero:**
- Siempre es lo primero que se ve al cargar la pagina
- `autoplay muted loop playsinline`, sin controles visibles
- Overlay gradient oscuro para legibilidad del texto

**Presupuesto:**
- Tabla completa con todos los rubros de proyecto.json
- Cards de resumen lateral: total, materiales, MO, costo/m2, costo/depto
- Nota aclaratoria al pie: sin IVA, sin honorarios

**Assets:**
- Todos los paths deben ser RELATIVOS (assets/imagen.png, no /assets/)
- Esto es critico para que GitHub Pages funcione correctamente

**Performance:**
- HTML unico (sin CSS/JS externos salvo Google Fonts)
- Sin dependencias npm ni bundlers
- El archivo index.html debe funcionar abriendolo directamente en un browser

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

## proyecto.json — Estructura de referencia

```json
{
  "proyecto": {
    "nombre": "Casa Rogeris",
    "subtitulo": "Complejo 4 Departamentos — Steel Frame",
    "descripcion": "Descripcion del proyecto...",
    "arquitecto": "Arq. Leonardo Diaz",
    "estudio": "SoyLeo AI",
    "superficie_total": "193 m²",
    "superficie_deptos": "168 m²",
    "superficie_pasarela": "25 m²",
    "unidades": "4 x 42 m²",
    "sistema": "Steel Frame",
    "ubicacion": "Tucuman, NOA",
    "año": "2025",
    "estado": "Proyecto ejecutivo",
    "email": "soyleo.ai.arq@gmail.com",
    "instagram": "@soy.leo_ai",
    "web": "soyleoai.com"
  },
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
      // ... mas rubros
    ],
    "totales": {
      "materiales": 81453300,
      "mano_de_obra": 50133200,
      "total_obra": 131240000,
      "costo_m2": 680000,
      "costo_depto": 32810000
    },
    "nota": "Presupuesto global orientativo. No incluye honorarios ni IVA."
  }
}
```

---

## Personalizacion por arquitecto

Cuando un arquitecto de la comunidad Antigravity use este kit, debe:

1. **Renombrar** `proyecto.json` datos con su proyecto
2. **Reemplazar** los archivos en `assets/` con su propio video e imagenes
3. **Ejecutar** en Claude Code: `Lee proyecto.json y regenera index.html con mis datos`
4. **Publicar** en su propio GitHub con el nombre de su proyecto

Cada arquitecto genera una URL unica para cada cliente.

---

## Creditos

Generado con **SoyLeo AI** — Sistema de documentacion arquitectonica con IA
Arq. Leonardo Diaz | Tucuman, Argentina
soyleoai.com | @soy.leo_ai | soyleo.ai.arq@gmail.com
