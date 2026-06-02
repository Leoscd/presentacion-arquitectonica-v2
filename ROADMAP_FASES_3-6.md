# ROADMAP — Fases 3 a 6 del Showroom 3D
## Repositorio: `Leoscd/presentacion-arquitectonica-v2`
## Estado actual: Fase 1 y Fase 2 completas y mergeadas en `develop`

Este documento es un **spec ejecutable** diseñado para que un agente de código (Claude Code, GitHub Copilot, o tu agente de Telegram) implemente las fases restantes siguiendo la arquitectura y convenciones ya establecidas.

---

## 📍 Estado actual (lo que YA está)

### Fase 1 — Schema + Sistema de marca (✅ mergeado en develop)
- `proyecto.json` con schema v2: `marca`, `edificio.pisos[]`, `sectores[]`, `features{}`
- Variables CSS renombradas a nombres semánticos (`--acento`, `--fondo`, `--texto`, etc.)
- Bloque `<style id="brand-vars">` agregado como placeholder
- 4 agentes extendidos con detección de marca, migración v1→v2, inyección de marca, validación WCAG
- 3 commits + 1 merge

### Fase 2 — Refactor estructural (✅ mergeado en develop)
- Inyección dinámica de variables de marca desde `proyecto.json.marca` al `<style id="brand-vars">`
- Actualización dinámica del `<link id="google-fonts">` cuando las fuentes de la marca son distintas a las default
- Loader cinematográfico con reveal de marca (eyebrow "Proyecto Arquitectónico" + nombre del estudio)
- Cursor custom dorado que se agranda sobre elementos interactivos (deshabilitado en mobile)
- Smooth scroll con Lenis (CDN, respeta `prefers-reduced-motion`)
- Modal teatro full-screen con:
  - Imagen del sector a la izquierda, info a la derecha
  - Botón "Ver Tour 360°" (aparece solo si `sectores[i].tour_360` existe)
  - Lista de características
  - Lista de materiales con marca/proveedor
  - Navegación "← Anterior" / "Siguiente →" + contador
  - Cierre con ESC, click fuera, o botón X
  - Soporte Pannellum preparado (carga lazy)
- Sectores renderizados dinámicamente desde `proyecto.json.sectores[]`
- 4 commits + 1 merge

### Estructura de ramas actual
```
main
 └─ develop
     ├─ feat/fase-1-marca-schema (mergeado)
     └─ feat/fase-2-refactor-estructural (mergeado)
```

---

## 🎯 Fases pendientes (objetivo del documento)

| # | Fase | Estimación | Entregable visible |
|---|---|---|---|
| 3 | Escena 3D con exploded view | 1–2 sesiones | Vista isométrica que se descompone al scroll |
| 4 | Presupuesto premium | 1 sesión | Donut SVG + CountUp animado |
| 5 | Tour 360 + Agente 5 Director 3D | 1–2 sesiones | Tours funcionales con Pannellum + coreografía animada |
| 6 | QA final + ASSETS_GUIDE.md | 1 sesión | Test end-to-end + documentación para arquitectos |

**Total estimado: 4–6 sesiones de Claude Code**

---

## 🔧 Convenciones a respetar

1. **HTML único** — `index.html` se mantiene como archivo único. No usar build tools ni frameworks.
2. **Librerías via CDN** — Usar `<script src="https://cdn.jsdelivr.net/...">` con `defer` o en `</body>`. Peso total objetivo: < 200KB agregado.
3. **Variables CSS semánticas** — Usar SIEMPRE `var(--acento)`, `var(--fondo)`, `var(--texto)`, etc. NO hardcodear colores.
4. **Schema v2** — Todo dato nuevo va al `proyecto.json` con la estructura v2. NO inventar campos nuevos sin documentarlos.
5. **Features flags** — Toda nueva feature debe tener su flag en `proyecto.json.features` y el Agente 4 debe validarlo contra assets.
6. **Commits chicos y descriptivos** — Convención: `feat(area): descripción` o `fix(area): descripción`. 1 commit por unidad lógica.
7. **Rama por fase** — `feat/fase-3-escena-3d`, `feat/fase-4-presupuesto-premium`, etc. Merge a `develop` con `--no-ff`.
8. **Mobile-first** — Todo CSS debe tener su equivalente `@media (max-width: 900px)`.
9. **Accesibilidad** — `prefers-reduced-motion: reduce` deshabilita animaciones pesadas. Contraste WCAG AA.
10. **Fallback siempre** — Si una feature flag está `true` pero no hay assets, la feature se desactiva con warning, no se rompe.

---

# 🎬 FASE 3 — Escena 3D con Exploded View

## Objetivo
Convertir la planimetría estática actual (`assets/planta3d.png`) en una **escena 3D pseudo-real** con CSS 3D Transforms + GSAP ScrollTrigger, donde el edificio se "descompone" al hacer scroll, revelando cada piso con su información.

## Estrategia técnica
- **No usar Three.js** (demasiado pesado para el caso de uso)
- **Usar CSS 3D Transforms** (`perspective`, `rotateX`, `translateZ`, `transform-style: preserve-3d`)
- **GSAP + ScrollTrigger** via CDN para las animaciones atadas al scroll
- Cada piso del JSON se renderiza como un `<div class="piso">` con la imagen del piso como `background-image`

## Archivos a tocar
- `index.html` (estructura HTML de la escena + CSS 3D + JS de GSAP)
- `agentes/3-disenador.md` (documentar cómo generar la escena desde JSON)
- `agentes/4-tester.md` (agregar validación de estructura de pisos)
- `proyecto.json` (si es mono_piso, ya hay datos; si no, agregar `assets/pisos/*.png`)

## Estructura HTML a agregar (dentro de `<section id="proyecto">`, antes de los hotspots actuales)

```html
<div id="edificio-3d" class="edificio-3d">
  <div class="scene-stage">
    <!-- Cada piso es un plano 3D apilado en Z -->
    <div class="piso" data-piso-id="principal" style="background-image: url('assets/planta3d.png')">
      <span class="piso-label">Planta Principal</span>
    </div>
  </div>
  <div class="scene-controls">
    <button class="scene-btn" data-mode="completo">Vista Completa</button>
    <button class="scene-btn" data-mode="explotado">Explotar Pisos</button>
    <button class="scene-btn" data-mode="cenital">Vista Cenital</button>
  </div>
  <div class="scene-info">
    <!-- Aquí se inyecta info del piso activo -->
  </div>
</div>
```

## CSS 3D a agregar

```css
.edificio-3d {
  position: relative;
  width: 100%;
  max-width: 1100px;
  height: 70vh;
  min-height: 500px;
  margin: 80px auto;
  perspective: 1500px;
  perspective-origin: 50% 30%;
}
.scene-stage {
  position: relative;
  width: 100%;
  height: 100%;
  transform-style: preserve-3d;
  transition: transform 1.2s cubic-bezier(0.65, 0, 0.35, 1);
}
.scene-stage[data-mode="completo"] { transform: rotateX(55deg) rotateZ(-30deg); }
.scene-stage[data-mode="explotado"] { transform: rotateX(45deg) rotateZ(-25deg); }
.scene-stage[data-mode="cenital"] { transform: rotateX(0deg) rotateZ(0deg); }

.piso {
  position: absolute;
  inset: 0;
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
  border: 1px solid var(--acento-mid);
  box-shadow: 0 30px 60px rgba(0,0,0,0.5);
  transform-style: preserve-3d;
  transition: transform 1.2s cubic-bezier(0.65, 0, 0.35, 1);
}

/* Cada piso se apila en Z inicialmente */
.piso[data-piso-id="principal"] { transform: translateZ(0); }
.piso[data-piso-id="p1"] { transform: translateZ(0); }
/* etc. */

/* Modo explotado: separa los pisos verticalmente */
.scene-stage[data-mode="explotado"] .piso[data-piso-id="principal"] { transform: translateZ(-200px); }
.scene-stage[data-mode="explotado"] .piso[data-piso-id="p1"] { transform: translateZ(0px); }
.scene-stage[data-mode="explotado"] .piso[data-piso-id="p2"] { transform: translateZ(200px); }

.piso-label {
  position: absolute;
  bottom: -40px; left: 50%;
  transform: translateX(-50%);
  font-family: var(--fuente-titulo);
  font-size: 14px;
  color: var(--acento);
  white-space: nowrap;
}
```

## JS a agregar (con GSAP via CDN)

```html
<script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js" defer></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/ScrollTrigger.min.js" defer></script>
```

```javascript
// En el <script> principal, después de initTheater()
gsap.registerPlugin(ScrollTrigger);

// Animar la entrada de la escena cuando entra en viewport
gsap.from('.edificio-3d', {
  scrollTrigger: {
    trigger: '.edificio-3d',
    start: 'top 80%',
    end: 'bottom 20%',
    scrub: 1
  },
  rotateX: 90,
  opacity: 0,
  duration: 1
});

// Botones de modo
document.querySelectorAll('.scene-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    const mode = btn.dataset.mode;
    document.querySelector('.scene-stage').dataset.mode = mode;
  });
});
```

## Commit sugerido
```
feat(3d): escena isometrica con CSS 3D transforms + GSAP ScrollTrigger + 3 modos de vista
```

## Validación
- Casa Rogeris (mono_piso) debe verse la planta en perspectiva isométrica
- Botones de modo deben funcionar (completo / explotado / cenital)
- Scroll debe activar la animación de entrada
- Mobile: deshabilitar perspectiva 3D, mostrar planta plana con hotspots

---

# 📊 FASE 4 — Presupuesto Premium (Donut + CountUp)

## Objetivo
Reemplazar la tabla estática y las cards de resumen por un **gráfico donut SVG animado** por rubro + **conteo animado de los totales** (efecto "contador de casino").

## Estrategia técnica
- **SVG donut** dibujado a mano (sin librerías)
- **CountUp.js** via CDN para la animación de los números
- Animación de trazo del donut con `stroke-dasharray` + `stroke-dashoffset` (CSS transitions)
- Tabla detallada queda como acordeón debajo del donut

## Estructura HTML a reemplazar (dentro de `<section id="presupuesto">`)

```html
<div id="presupuesto-header">
  <div class="presupuesto-donut">
    <svg viewBox="0 0 200 200" class="donut-svg">
      <!-- Cada rubro es un <circle> con stroke segmentado -->
      <circle class="donut-segment" data-rubro="01" data-valor="2626000" cx="100" cy="100" r="80" />
      <circle class="donut-segment" data-rubro="02" data-valor="10534000" cx="100" cy="100" r="80" />
      <!-- ... uno por rubro -->
      <text class="donut-total" x="100" y="100">$ 0</text>
    </svg>
  </div>
  <div class="presupuesto-legend">
    <!-- Generado dinámicamente desde JSON -->
  </div>
</div>

<div class="presupuesto-counts">
  <div class="count-card">
    <div class="count-label">Total Inversión</div>
    <div class="count-value" data-target="131240000" data-prefix="$ ">0</div>
  </div>
  <div class="count-card">
    <div class="count-label">Costo por M²</div>
    <div class="count-value" data-target="680000" data-prefix="$ ">0</div>
  </div>
  <div class="count-card">
    <div class="count-label">Costo por Unidad</div>
    <div class="count-value" data-target="32810000" data-prefix="$ ">0</div>
  </div>
</div>

<table class="rubros-table">
  <!-- Misma tabla de v1, generada desde JSON -->
</table>
```

## CSS a agregar

```css
.donut-svg {
  width: 100%;
  max-width: 400px;
  height: auto;
  transform: rotate(-90deg); /* Para que los segmentos empiecen arriba */
}
.donut-segment {
  fill: none;
  stroke-width: 32;
  stroke-dasharray: 0 502; /* 2*PI*80 = 502.65 */
  transition: stroke-dasharray 1.5s ease, stroke 0.3s, opacity 0.3s;
  cursor: pointer;
}
.donut-segment:hover {
  opacity: 0.7;
  stroke-width: 38;
}
.donut-total {
  font-family: var(--fuente-titulo);
  font-size: 24px;
  fill: var(--acento);
  text-anchor: middle;
  dominant-baseline: central;
  transform: rotate(90deg); /* Compensar el rotate del SVG */
  transform-origin: center;
}
```

## Cálculo de stroke-dasharray por rubro

Para cada rubro del JSON, calcular:
- `incidencia_porcentual = (rubro.total / total_obra) * 100`
- `longitud_segmento = (incidencia_porcentual / 100) * 502.65`
- `dasharray_total = longitud_segmento + ' ' + (502.65 - longitud_segmento)`
- Posicionar con `stroke-dashoffset` acumulado de segmentos anteriores

## JS a agregar

```html
<script src="https://cdn.jsdelivr.net/npm/countup.js@2.8.0/dist/countUp.umd.js" defer></script>
```

```javascript
// Calcular total para el donut
const total = data.presupuesto.totales.total_obra;
const radio = 80;
const circunferencia = 2 * Math.PI * radio;
let offset = 0;

document.querySelectorAll('.donut-segment').forEach((seg, idx) => {
  const rubro = data.presupuesto.rubros[idx];
  const inc = rubro.total / total;
  const segLength = inc * circunferencia;
  seg.style.strokeDasharray = `${segLength} ${circunferencia - segLength}`;
  seg.style.strokeDashoffset = -offset;
  // Color rotando por la paleta de acento
  seg.style.stroke = idx % 2 === 0 ? 'var(--acento)' : 'var(--acento-mid)';
  offset += segLength;
});

// Animar el total en el centro del donut
const donutTotal = new countUp.CountUp(document.querySelector('.donut-total'), total, {
  duration: 2,
  separator: '.',
  prefix: '$ '
});
// Trigger con IntersectionObserver
const observer = new IntersectionObserver(entries => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      donutTotal.start();
      observer.unobserve(e.target);
    }
  });
});
observer.observe(document.querySelector('.donut-svg'));

// CountUp para las cards
document.querySelectorAll('.count-value').forEach(el => {
  const target = parseInt(el.dataset.target, 10);
  const cu = new countUp.CountUp(el, target, {
    duration: 2,
    separator: '.',
    prefix: el.dataset.prefix || ''
  });
  const obs2 = new IntersectionObserver(entries => {
    if (entries[0].isIntersecting) {
      cu.start();
      obs2.unobserve(el);
    }
  });
  obs2.observe(el);
});
```

## Commit sugerido
```
feat(presupuesto): donut SVG animado por rubro + CountUp en totales
```

## Validación
- Donut se anima al entrar en viewport (los segmentos se "dibujan")
- Hover sobre segmento lo resalta
- Total en el centro cuenta desde 0 hasta el valor final
- 3 cards de resumen también animan al entrar en viewport
- Tabla de rubros sigue funcionando (igual que v1)

---

# 🌐 FASE 5 — Tour 360 con Pannellum + Agente 5 Director 3D

## Objetivo
Activar los tours 360° cuando hay imágenes equirectangulares en `assets/360/`, y crear el **Agente 5 Director 3D** que define la coreografía de animaciones según la estructura del proyecto.

## Estrategia técnica
- **Pannellum** via CDN (`https://cdn.jsdelivr.net/npm/pannellum@2.5.6/build/pannellum.css` + `.js`)
- El modal teatro ya tiene el botón "Ver Tour 360°" preparado (Fase 2), solo falta cargar Pannellum lazy
- Agente 5 se crea como nuevo archivo `.md` y se invoca después del Agente 2 (Articulador)

## Archivos a tocar
- `index.html` (cargar Pannellum CSS + JS + inicialización lazy en el modal)
- `agentes/5-director-3d.md` (NUEVO)
- `agentes/3-disenador.md` (documentar cómo integrar el output del Agente 5)
- `crear_landing.sh` (agregar invocación del Agente 5 en el pipeline)
- `README.md` (documentar la existencia del Agente 5)

## Pannellum a agregar

```html
<!-- En <head> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pannellum@2.5.6/build/pannellum.css">

<!-- Antes de </body> -->
<script src="https://cdn.jsdelivr.net/npm/pannellum@2.5.6/build/pannellum.js" defer></script>
```

Y en el JS del modal teatro, ya está preparado el código de Pannellum en `initTheater()` (Fase 2). Solo verificar que se carga.

## Contenido del Agente 5 (`agentes/5-director-3d.md`)

```markdown
# 🎬 Agente Director 3D (v2)

## Misión Principal
Eres el Director 3D del Equipo Arquitectónico. Tu propósito es generar el **guion coreográfico** de las animaciones 3D (Fase 3) y la distribución de hotspots 3D en el espacio, basándote en la estructura de `proyecto.json.edificio.pisos[]`.

## Skills (Habilidades)
- **Coreografía de Scroll:** Definir en qué momento del scroll se activan las animaciones
- **Posicionamiento 3D:** Calcular las coordenadas XYZ de cada piso en el espacio 3D
- **Curaduría de Experiencia:** Decidir el "ritmo" de la presentación según la complejidad del proyecto
- **Cálculo de Cámaras:** Definir posición, ángulo y zoom de cámaras virtuales

## Procedimiento (SOP)
1. Lee `proyecto.json.edificio.pisos[]`
2. Calcula la separación vertical entre pisos según `altura_metros`:
   - Pisos mono_piso: separación = 0 (solo 1 piso)
   - Pisos multi_piso: separación = 250-400px en Z (proporcional a la altura)
3. Define el modo de entrada de la escena:
   - 1 piso → rotación lenta automática
   - 2-3 pisos → explosión con scroll
   - 4+ pisos → explosión con scroll + indicador de "scroll para ver más"
4. Genera el bloque `animaciones` que se inyecta en `index.html`:
   ```json
   "animaciones": {
     "explosion": {
       "trigger_scroll": "30%",
       "duracion": 1200,
       "easing": "cubic-bezier(0.65, 0, 0.35, 1)",
       "separacion_pisos": 280
     },
     "camara_sector": {
       "duracion": 800,
       "zoom_factor": 2.5
     }
   }
   ```
5. Si el proyecto es simple (1 piso, 2 sectores), recomienda animaciones más sutiles. Si es complejo (4+ pisos, 10+ sectores), recomienda escena más dramática.

## Curación por tipo de proyecto
- **mono_piso / 1 unidad**: rotación 360° lenta del render, sin explosión
- **mono_piso / multi_unidad**: 4 unidades lado a lado en 3D, sin explosión
- **multi_piso / 2-3 pisos**: explosión con scroll, separación media
- **multi_piso / 4+ pisos**: explosión dramática, scroll-driven storytelling

## Output
Escribe el bloque `animaciones` directamente en `proyecto.json` bajo la clave `edificio.animaciones`. El Agente 3 (Diseñador) lo lee para generar la escena 3D.
```

## Actualización de `crear_landing.sh`

Agregar la línea del Agente 5 después del Agente 2:

```bash
echo "   -> 🎬 Ejecutando Agente Director 3D (Coreografía)..."
claude -p "$(cat agentes/5-director-3d.md)" > /dev/null
```

## Commit sugerido
```
feat(360): Pannellum integrado en modal teatro
feat(agentes): nuevo Agente 5 Director 3D con coreografía de animaciones
docs(readme): documentar Agente 5 y pipeline completo
```

## Validación
- Si el arquitecto provee `assets/360/cocina.jpg` (equirectangular 2:1), al hacer click en el sector "cocina" del modal teatro, aparece el botón "Ver Tour 360°"
- Al click, se carga el panorama en una vista 360° navegable con mouse/touch
- Si no hay archivo 360°, el botón no aparece
- Pannellum pesa ~50KB y se carga via CDN solo cuando se necesita

---

# ✅ FASE 6 — QA Final + ASSETS_GUIDE.md

## Objetivo
Test end-to-end con Casa Rogeris (caso testigo), documentar para futuros arquitectos cómo obtener los assets, y crear un script de demo.

## Tareas específicas

### 6.1 — Test end-to-end con Casa Rogeris
- [ ] La landing carga sin errores en consola
- [ ] El loader aparece, dura 2.2s, se desvanece
- [ ] El cursor custom es visible en desktop, no en mobile
- [ ] El scroll es suave (Lenis)
- [ ] Los 3 hotspots abren el modal teatro con datos correctos
- [ ] El modal teatro se cierra con ESC, click fuera, o X
- [ ] La navegación "← Anterior / Siguiente →" funciona
- [ ] El gráfico donut del presupuesto se anima al entrar en viewport
- [ ] Los totales cuentan desde 0 al entrar en viewport
- [ ] Si se cambia el JSON a `preset: "light-marble"`, los colores cambian
- [ ] Lighthouse score > 90 en Performance y > 95 en Accessibility

### 6.2 — Crear `ASSETS_GUIDE.md`

Documento para futuros arquitectos, con secciones:
1. **Mínimo viable**: qué archivos necesitan
2. **Recomendado**: cómo mejorar el showroom
3. **Pro**: tours 360° paso a paso
4. **Tabla de fuentes de assets 360°** (Skybox AI, Lumion, cámara 360°, etc.)
5. **Tabla de presets de marca** con screenshots

### 6.3 — Crear `docs/demo/` con screenshots
- Capturas de Casa Rogeris en estado final
- Capturas de los 3 presets de marca aplicados
- 1 video corto (10-20s) de la interacción (opcional, puede ser GIF)

### 6.4 — Tag v2.0.0
```bash
git tag -a v2.0.0 -m "Showroom 3D v2 - marca dinamica, exploded view, donut presupuesto, tour 360"
git push origin v2.0.0
```

### 6.5 — PR final a main
PR de `develop` → `main` con descripción detallada del release.

## Commit sugerido
```
docs(qa): ASSETS_GUIDE.md para futuros arquitectos
docs(demo): capturas de Casa Rogeris en 3 presets de marca
chore(release): tag v2.0.0 con showroom 3D completo
```

## Validación
- Lighthouse score publicado en el README
- ASSETS_GUIDE.md linkeado desde el README
- Tag v2.0.0 visible en GitHub Releases

---

# 📚 Recursos y Referencias

## Librerías usadas (todas via CDN)
- **Lenis** (smooth scroll): `https://cdn.jsdelivr.net/npm/lenis@1.1.13/dist/lenis.min.js`
- **GSAP** (animaciones): `https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js`
- **GSAP ScrollTrigger**: `https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/ScrollTrigger.min.js`
- **Pannellum** (tour 360): `https://cdn.jsdelivr.net/npm/pannellum@2.5.6/build/pannellum.css` + `.js`
- **CountUp.js** (contadores): `https://cdn.jsdelivr.net/npm/countup.js@2.8.0/dist/countUp.umd.js`

## Showrooms arquitectónicos de referencia
- BIG (Bjarke Ingels Group): https://big.dk
- Foster + Partners: https://www.fosterandpartners.com
- Zaha Hadid Architects: https://www.zaha-hadid.com
- MAD Architects: https://www.i-mad.com
- Studio Gang: https://studiogang.com
- Snøhetta: https://snohetta.com

## Herramientas para assets 360°
- **Skybox AI** (gratis): https://skybox.blockadelabs.com
- **Lumion** (de pago, pero ya lo tienen los arquitectos): https://lumion.com
- **Insta360 X3** (cámara ~USD 450): https://www.insta360.com
- **Google Street View app** (gratis para fotos con celular)

---

# 🚀 Orden de ejecución recomendado

Si vas a implementar todo de una, el orden óptimo es:

1. **Fase 3** primero (lo más WOW, la escena 3D)
2. **Fase 4** segundo (donut presupuesto, refuerza el "wow")
3. **Fase 5** tercero (tours 360, agrega valor tangible)
4. **Fase 6** último (QA + docs + release)

**Total: 4-6 sesiones de Claude Code**

---

# 📋 Checklist general al terminar el v2 completo

- [ ] Todas las fases mergeadas a `develop`
- [ ] PR de `develop` → `main` mergeado
- [ ] Tag `v2.0.0` creado
- [ ] GitHub Pages de `main` muestra el showroom completo
- [ ] Lighthouse score > 90 en Performance
- [ ] ASSETS_GUIDE.md publicado
- [ ] Screenshots en `docs/demo/`
- [ ] Casa Rogeris valida los 3 presets de marca

---

**Cualquier duda, consultar `CLAUDE.md` que está actualizado al v2 con el schema, comandos y pipeline completo.**
