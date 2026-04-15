# 🎓 Taller: Arquitectura y Evolución del Desarrollo Móvil

## ✅ COMPLETO — Estructura Organizada por Carpetas

**Grupo:** Dilan Elías Angulo + Melany Lema  
**Aplicaciones de Estudio:** Airbnb y Spotify  
**Fecha:** Abril 2026  
**Total:** ~70,000 palabras, 9 documentos principales + 2 READMEs, 2 master docs

---

## � Estructura de Carpetas

```
TareaEnClase01/
│
├── 📁 Parte-1-Fundamentos/         ← MARCO TEÓRICO
│   ├─ 01-Marco-Teorico-Evolucion-Movil.md
│   ├─ 02-Matriz-Comparativa-Arquitectonica.md
│   ├─ 03-Nuevas-Interfaces-Riesgos-Tecnicos.md
│   ├─ 04-Glosario-Tecnico-Defensa-Oral.md
│   ├─ 05-Plantilla-Criterios-Decision.md
│   └─ README-Parte-1.md
│
├── 📁 Parte-2-Analisis-Casos/      ← CASOS REALES (Airbnb + Spotify)
│   ├─ Parte-2a-Airbnb-Caso-Estudio.md
│   ├─ Parte-2b-Spotify-Caso-Estudio.md
│   ├─ Parte-2c-Veredicto-Critico.md
│   └─ README-Parte-2.md
│
├─ MASTER-Indice-Consolidado.md    ← RESUMEN TOTAL (este es el importante)
└─ README-Indice.md                 ← Guía rápida (este archivo)
```

---

## 📄 Documentos Principales

### PARTE 1: FUNDAMENTOS TEÓRICOS

#### 1. [Marco Teórico de la Evolución Móvil](Parte-1-Fundamentos/01-Marco-Teorico-Evolucion-Movil.md)
**Propósito:** Entender la historia y arquitectura de cada paradigma

**Contenido:**
- Desarrollo Nativo Puro (iOS/Android): tecnologías, arquitectura, fortalezas/debilidades
- Era del WebView/Híbrido (Cordova, PhoneGap, Ionic): por qué surgió, cómo funciona, vigencia actual
- Puente Nativo-JavaScript (React Native clásico vs moderno): arquitectura con/sin JSI
- Motor de Renderizado Propio (Flutter): cómo render pipeline completo genera ventajas
- Futuro (Foldables, AR/XR, Wearables): requisitos arquitectónicos y limitaciones

**Pregunta clave respondida:** ¿Qué es un aplicativo nativo? ¿Hay varios? ¿Cómo se clasifican?

---

#### 2. [Matriz Comparativa Arquitectónica](Parte-1-Fundamentos/02-Matriz-Comparativa-Arquitectonica.md)
**Propósito:** Comparar objetivamente todas las opciones

**Contenido:**
- Tabla maestra: 20+ criterios (performance, costo, acceso hardware, etc.)
- Frame detailing: Desglose de latencia en cada paradigma (16.67ms @ 60 FPS)
- Matriz de acceso a hardware (GPS, NFC, AR, LiDAR, etc.)
- Matriz de casos de uso (cuándo usar qué)
- Curvas TCO (Total Cost of Ownership) en el tiempo
- Risk matrix (riesgos técnicos 2026)

**Uso:** Respalda argumentos con números concretos

---

#### 3. [Nuevas Interfaces: Riesgos Técnicos](Parte-1-Fundamentos/03-Nuevas-Interfaces-Riesgos-Tecnicos.md)
**Propósito:** Entender qué demandan nuevos paradigmas y quién puede entregarlo

**Contenido:**
- **Foldables:** El problema (1200ms transición), soluciones (state reactivity), viabilidad (Nativo ✓, Flutter ✓, RN ⚠, Hybrid ✗)
- **AR/XR:** Latency budget (< 50ms cyber-sickness), stack completo (sensor fusion, physics, GPU), viabilidad (Nativo ✓✓, RN con overhead, Flutter similar)
- **Wearables:** Energy budget, CPU débil, viabilidad (Nativo ✓, Flutter ⚠, RN ✗)
- **AR Glasses 2030:** Especulación técnica; conclusión = nativo puro

**Insight clave:** Cross-platform muere en AR/XR avanzado; nativo + engine 3D (Unity/Unreal) es real

---

#### 4. [Glosario Técnico para Defensa Oral](Parte-1-Fundamentos/04-Glosario-Tecnico-Defensa-Oral.md)
**Propósito:** Definir términos para no sonar vago en la presentación

**Contenido (A-Z):**
- AOT, Bridge, Cyber-sickness, Dart, Event Loop
- Fabric, Garbage Collection, Hot Reload
- IMU, JIT, Kotlin
- Latency Budget, Memory Footprint, Native Bridge
- Occlusion, Platform Channel, Plugin
- Render Pipeline, React Native
- Skia, Snapdragon, TurboModules
- UIKit, Vulkan, WebView
- XR, ZERO-COPY

**Bonus:** Frases clave para memorizar y no sonar genérico

---

#### 5. [Plantilla de Criterios de Decisión](Parte-1-Fundamentos/05-Plantilla-Criterios-Decision.md)
**Propósito:** Framework para analizar por qué Airbnb y Spotify eligieron sus techs

**Contenido:**
- Checklist maestra (responde preguntas, asigna puntos)
- Rubric: Requisitos negocio, técnicos, dominio, dispositivos, equipo
- Matriz de scoring (auto-calcular ganador)
- Reglas de desempate
- Scoring real: Airbnb y Spotify análisis completado
- Preguntas de reflexión final

**Uso práctico:** Llena para Airbnb, llena para Spotify, explica decisiones

---

### PARTE 2: ANÁLISIS DE CASOS REALES

#### 1. [Airbnb - Caso de Estudio](Parte-2-Analisis-Casos/Parte-2a-Airbnb-Caso-Estudio.md)
**Propósito:** Análisis arquitectura e ingeniería inversa
**Key:** Nativo porque performance 60 FPS @ 100M+ users

#### 2. [Spotify - Caso de Estudio](Parte-2-Analisis-Casos/Parte-2b-Spotify-Caso-Estudio.md)
**Propósito:** Análisis arquitectura e ingeniería inversa
**Key:** Nativo porque audio latency < 50ms + wearables

#### 3. [Veredicto Crítico](Parte-2-Analisis-Casos/Parte-2c-Veredicto-Critico.md)
**Propósito:** Respuestas a TODAS las preguntas del taller
**Key:** Ingeniería inversa + desafíos + nuevas interfaces + veredicto 2026

---

## 🗺️ Guía de Navegación

### ⚡ Quick Start (15 min)
1. Lee [MASTER-Indice-Consolidado.md](MASTER-Indice-Consolidado.md) (resumen ejecutivo)
2. Lee [Parte-2c-Veredicto-Critico.md](Parte-2-Analisis-Casos/Parte-2c-Veredicto-Critico.md) (las preguntas del taller)

### 📖 Para Presentación (45 min)
1. [Parte-1-Fundamentos/README-Parte-1.md](Parte-1-Fundamentos/README-Parte-1.md) — Qué leer de Fundamentos (2 min)
2. [Parte-2a-Airbnb](Parte-2-Analisis-Casos/Parte-2a-Airbnb-Caso-Estudio.md) secciones 1-3 (10 min)
3. [Parte-2b-Spotify](Parte-2-Analisis-Casos/Parte-2b-Spotify-Caso-Estudio.md) secciones 1-3 (10 min)
4. [Parte-2c-Veredicto](Parte-2-Analisis-Casos/Parte-2c-Veredicto-Critico.md) Preguntas 1-4 (15 min)
5. [Glosario](Parte-1-Fundamentos/04-Glosario-Tecnico-Defensa-Oral.md) Frases clave (8 min)

### 📚 Para Estudio Profundo (2+ horas)
1. Lee TODO en [Parte-1-Fundamentos/README-Parte-1.md](Parte-1-Fundamentos/README-Parte-1.md)
2. Lee TODO en [Parte-2-Analisis-Casos/README-Parte-2.md](Parte-2-Analisis-Casos/README-Parte-2.md)
3. Usa [Parte-1-Fundamentos/05-Plantilla-Criterios-Decision.md](Parte-1-Fundamentos/05-Plantilla-Criterios-Decision.md) para tu propio análisis

### 🔍 Por Tema Específico
- **"¿Qué es nativo?"** → [Parte-1: Marco-Teorico](Parte-1-Fundamentos/01-Marco-Teorico-Evolucion-Movil.md)
- **"¿Cuándo usar nativo vs Flutter vs RN?"** → [Parte-1: Matriz](Parte-1-Fundamentos/02-Matriz-Comparativa-Arquitectonica.md)
- **"¿Puede RN hacer AR?"** → [Parte-1: Nuevas-Interfaces](Parte-1-Fundamentos/03-Nuevas-Interfaces-Riesgos-Tecnicos.md)
- **"¿Qué significa 'bridge'?"** → [Parte-1: Glosario](Parte-1-Fundamentos/04-Glosario-Tecnico-Defensa-Oral.md)
- **"¿Por qué Airbnb eligió nativo?"** → [Parte-2a sección 3](Parte-2-Analisis-Casos/Parte-2a-Airbnb-Caso-Estudio.md)
- **"¿Por qué Spotify nativo?"** → [Parte-2b sección 3](Parte-2-Analisis-Casos/Parte-2b-Spotify-Caso-Estudio.md)
- **"¿Veredicto hoy 2026?"** → [Parte-2c pregunta 4](Parte-2-Analisis-Casos/Parte-2c-Veredicto-Critico.md)

---

## ❓ Preguntas de la Práctica (Parte 2)

Para Airbnb y Spotify, deberán responder:

### Ingeniería Inversa de la Decisión
1. ¿Por qué Airbnb eligió su arquitectura (vs alternatives)?
2. ¿Por qué Spotify eligió la suya?

### Análisis de Rendimiento y Arquitectura
3. ¿Qué desafíos arquitectónicos enfrenta Airbnb (mapas, navegación)?
4. ¿Qué cuello de botella tuvo que resolver Spotify (audio, recomendaciones)?

### El Desafío de Nuevas Pantallas
5. Si Apple/Samsung usan AR Glasses como flagship → ¿cuál tech (Airbnb/Spotify) se adapta mejor?

### Veredicto Crítico
6. Si **hoy** (2026) listar propiedades 3D + gestión inventario complejarequiere foldables + AR → ¿Nativo, RN o Flutter?
7. Si **hoy** distribuir música con notificaciones de alta frecuencia + soporte wearables → ¿cuál?

---

## 📊 Estructura General del Taller

```
PARTE 1: INVESTIGACIÓN TEÓRICA (COMPLETADA ✓)
├─ 01: Historia (nativo → webview → RN → Flutter → futuro)
├─ 02: Comparativa (cuantitativa)
├─ 03: Nuevas interfaces (limitaciones reales)
├─ 04: Glosario (vocabulario técnico)
└─ 05: Plantilla decisión (framework)

PARTE 2: ANÁLISIS DE CASOS REALES (COMPLETADA ✓)
├─ Parte-2a: Airbnb (nativo, performance-driven)
├─ Parte-2b: Spotify (nativo, audio-driven)
└─ Parte-2c: Veredicto crítico (respuestas + conclusiones)

PRÓXIMO (Si aplica):
└─ Parte 3: Presentación oral + Defensa
```

---

## 🔧 Notas Prácticas

### Cómo Investigar Airbnb y Spotify

**Fuentes confiables:**
1. **Engineering blogs oficiales:**
   - Airbnb (engineering.airbnb.com)
   - Spotify (engineering.spotify.com)

2. **Conferencias (YouTube):**
   - React Native en Conferences (RN adoption decisions)
   - Flutter in 2024 talks (Google I/O)

3. **GitHub:**
   - Airbnb open-source repos (react-native-maps, react-native-maps-directions)
   - Spotify open-source repos

4. **Móvil (Descargar las apps):**
   - Analyticstool (MobSF) → reverse engineer APK
   - Xcode profiler (iOS)
   - Android Profiler (Android) → ver real memory, CPU, GPU

5. **Podcasts técnicos:**
   - Changelog, Software Engineering Daily

### Red Flags en Answers
- "Usamos X porque es popular" ← mal ragumentado
- "X es mejor que Y" sin métricas ← vago
- "Porque Google/Meta lo usan" ← cargo culto, no ingeniería

### Green Flags en Answers
- "Elegimos X porque rendimiento crítica en Y métrica"
- "Instrumentamos con Z tool, medimos latency de A a B"
- "Trade-off: perdemos Z, ganamos W; asumible porque..."

---

## 🚀 Siguientes Pasos

1. **Lee Parte 2 en orden:**
   - Parte-2a-Airbnb (arquitectura, historia, decisión)
   - Parte-2b-Spotify (arquitectura, historia, decisión)
   - Parte-2c-Veredicto (respuestas a preguntas críticas)

2. **Integra el glosario:** Mientras lees, refuerza términos clave de 04-Glosario

3. **Prepara presentación:**
   - Resumen ejecutivo: Airbnb vs Spotify (por qué cada uno eligió su path)
   - Análisis técnico: Desafíos resueltos, trade-offs
   - Veredicto: Qué elegiríamos hoy (2026) y por qué

4. **Practica defensa:** 
   - Memoriza frases clave (end of 04-Glosario)
   - Entiende diferencia entre bridge vs motor propio (no solo repitas)
   - Puedes responder "¿Por qué nativo en vez de RN/Flutter?" sin sonar vago

5. **Bonus:** Revisa Parte 1 si encuentras caoyos durante presentación

---

## 📚 Referencias Generales

- Flutter Performance (flutter.dev/docs/perf)
- React Native Architecture 2021+ (facebook.github.io/react-native)
- ARCore docs (developers.google.com/ar)
- ARKit docs (developer.apple.com/arkit)
- Nubank Engineering: "How We Scaled Flutter"
- Airbnb Blog: React Native learnings (2018, pero contexto útil)
- Spotify Blog: Mobile stack (available on engineering.spotify.com)

---

## ✅ Checklist Antes de Presentar

- [ ] Lei [MASTER-Indice-Consolidado.md](MASTER-Indice-Consolidado.md)
- [ ] Lei [Parte-2c-Veredicto-Critico.md secciones 1-4](Parte-2-Analisis-Casos/Parte-2c-Veredicto-Critico.md)
- [ ] Entiendo por qué Airbnb cambió (performance @ scale)
- [ ] Entiendo por qué Spotify siempre fue nativo (audio latency)
- [ ] Sé responder "¿nativo vs RN vs Flutter HOY?" sin sonar vago
- [ ] Memoricé 5-10 términos clave de [Glosario](Parte-1-Fundamentos/04-Glosario-Tecnico-Defensa-Oral.md)

---

## 🚀 Siguientes Pasos

1. **Abre** [MASTER-Indice-Consolidado.md](MASTER-Indice-Consolidado.md) para resumen ejecutivo
2. **Entra a carpetas:**
   - [Parte-1-Fundamentos/](Parte-1-Fundamentos/) para teoría
   - [Parte-2-Analisis-Casos/](Parte-2-Analisis-Casos/) para análisis
3. **Lee los READMEs de cada carpeta** para guía específica
4. **Practica defensa oral** con ejemplos concretos (nunca genéricos)

---

**¡Listo para presentación y defensa!**

