# Marco Teórico: Evolución Arquitectónica del Desarrollo Móvil

**Grupo:** Dilan Elías Angulo y Melany Lema  
**Aplicaciones a Analizar:** Airbnb y Spotify  
**Curso:** Taller de Arquitectura Móvil - EPN

---

## 1. Desarrollo Nativo Puro (iOS/Android)

### Definición
Construir aplicaciones específicamente para cada plataforma utilizando sus herramientas oficiales, lenguajes nativos y acceso directo al stack del sistema operativo.

### Stack Tecnológico

#### iOS
- **Lenguajes:** Swift (moderno) u Objective-C (legacy)
- **Frameworks UI:** SwiftUI (declarativo moderno) o UIKit (imperativo)
- **Compilación:** Swift compiler a código máquina ARM64
- **Runtime:** Cocoa Touch, Darwin kernel, Metal para gráficos

#### Android
- **Lenguajes:** Kotlin (recomendado) o Java (legacy)
- **Frameworks UI:** Jetpack Compose (declarativo) o Views tradicionales
- **Compilación:** Kotlin/Java a bytecode, luego ART (Android Runtime) JIT/AOT
- **Runtime:** Dalvik/ART, Linux kernel, OpenGL ES/Vulkan para gráficos

### Arquitectura Interna
```
┌─────────────────────────────────┐
│   Aplicación Nativa (Swift/Kotlin)
├─────────────────────────────────┤
│   SDK Oficial (UIKit/Jetpack)    │
├─────────────────────────────────┤
│   APIs del SO (GPS, Bluetooth, etc.) │
├─────────────────────────────────┤
│   Hardware (GPU, CPU, Sensores)  │
└─────────────────────────────────┘
```

**Sin capas intermedias:** La app controla directamente el ciclo de vida, threading, memoria y llamadas a sistema.

### Fortalezas Arquitectónicas

1. **Rendimiento máximo:** Sin overhead de traducción ni serialización; acceso directo a instrucciones máquina.
2. **Acceso completo a hardware:** Cámaras de ultra-gran angular, LiDAR, Bluetooth LE, biometría avanzada, sensores de proximidad.
3. **Integración profunda con el SO:** Widgets, extensiones, notificaciones ricas, Handoff (iOS), Continuidad.
4. **Frame budget predecible:** 16.67 ms @ 60 FPS sin sorpresas del runtime.
5. **Seguridad de grado militar:** APIs de encriptación, sandboxing, acceso a Secure Enclave / TEE.
6. **UX coherente:** Componentes que el usuario ya conoce, gestos nativos, animaciones del SO.

### Debilidades Arquitectónicas

1. **Costo de desarrollo muy alto:** Dos equipos especializados (iOS y Android) o desarrollo serial.
2. **Mantenimiento duplicado:** Bugs fixes, features nuevas, refactors en ambas codebases.
3. **Curva de aprendizaje:** Cada plataforma tiene paradigmas distintos (opcionales en Swift vs nullables obligatorios en Kotlin).
4. **Fragmentación Android:** Variedad de dispositivos, tamaños, ratios de pantalla, versiones de API (aunque KMP/Jetpack mitigan).

### Vigencia Actual (2026)

**Muy vigente y creciendo** en:
- Banca digital crítica (transacciones, autenticación biométrica)
- Aplicaciones de salud (regulación FDA/CE, acceso a sensor cardíaco, privacidad HIPAA)
- Gaming AAA (Genshin Impact, valorant Mobile)
- Fotografía profesional (acceso a RAW, modo Pro)
- AR avanzada (ARKit 6, ARCore con ML)
- Apps de tiempo real de ultra-baja latencia (trading, control industrial)

**Tendencia:** En 2026 sigue siendo la referencia. Incluso compañías que usaban cross-platform puro (como Figma) tienen piezas críticas en nativo.

---

## 2. Era del WebView / Híbrido (Cordova, PhoneGap, Ionic inicial)

### Definición
Empaquetar la aplicación web completa (HTML, CSS, JavaScript) dentro de un WebView embebido, ejecutado como aplicación móvil.

### Stack Tecnológico
- **Lenguajes:** HTML5, CSS3, JavaScript ES5+
- **Frameworks:** jQuery, Backbone, Angular 1, Ionic 1-2
- **Acceso Nativo:** Plugins que exponen APIs del SO vía JavaScript bridge primitivo
- **Tooling:** Cordova CLI, PhoneGap Build, Webpack

### Arquitectura Interna
```
┌──────────────────────────────────┐
│   HTML/CSS/JavaScript (Main Thread) │
├──────────────────────────────────┤
│   WebView (Chromium engine)      │
├──────────────────────────────────┤
│   Plugin Bridge (JSON serialization) │
├──────────────────────────────────┤
│   APIs Nativas (Objective-C/Java) │
├──────────────────────────────────┤
│   Hardware                        │
└──────────────────────────────────┘
```

**Cuello de botella:** Cada acceso a hardware requiere serializar a JSON, enviar por el bridge, procesar, deserializar, esperar.

### Por qué Surgió Históricamente

**2008-2012:** Era pre-smartphone. El mercado fragmentado demandaba presencia en iOS y Android sin presupuesto de dos apps nativas. Solución pragmática: una web app reutilizable.

### Fortalezas

1. **Velocidad de desarrollo inicial:** Reutilizar talento web era mucho más rápido que contratar desarrolladores iOS/Android.
2. **Una sola base de código:** Cambios en lógica sin duplicación.
3. **Bajo costo de entrada:** No requería conocer ObjectiveC/Swift.
4. **Fácil deployment:** Actualizar sin App Store review (en algunos casos).

### Debilidades Arquitectónicas

1. **Rendimiento UI pobre:** WebView no es optimizada para interacciones complejas de móvil.
   - Scroll de listas largas = janky (50 FPS, no 60)
   - Animaciones laggy
   - Memoria bloated

2. **Latencia de bridge:** Cada interacción con hardware pasa por serialización → overhead.

3. **Limitaciones funcionales:** Muchas APIs nativas no tienen plugin equivalente.

4. **UX no-nativa:** Gestos, tipografía, layout no sienten como la plataforma.

5. **Fragmentación WebView:** El WebView en Android variaba mucho entre versiones; iOS WebView era limitado hasta reciente (iOS 15+).

### Vigencia Actual (2026)

**En declive relativo**, pero **aún válido para:**
- Apps empresariales internas (CRUD sobre API REST) donde UI no es crítica
- MVPs rápidos de producto (validación de mercado antes de invertir en nativo/flutter)
- Apps de contenido estático (lectura de noticias, catálogos)
- Startups con presupuesto muy limitado

**Desapareció de:**
- Apps de consumidor premium
- Cualquier app que mida KPI de engagement / retention (performance importa)

---

## 3. Puente Nativo-JavaScript (React Native, inicialmente Xamarin.Forms, algunos híbridos nuevos)

### Definición
Lógica y estado viven en un runtime JavaScript. Componentes visuales **sí son nativos**, coordinados por un bridge de comunicación entre JS y código nativo.

### Stack Tecnológico

#### React Native (Caso principal)
- **Lenguajes:** JavaScript/TypeScript, Java/Kotlin (Android), Objective-C/Swift (iOS)
- **Compilación:** JS no compilado (interpretado o JIT), código nativo compilado por cada plataforma
- **Architecture:** 
  - Viejo (hasta 2021): bridge de JavaScript/Native síncrono con colas
  - Nuevo (2021+): JSI (JavaScript Interface), TurboModules, Fabric, Concurrent rendering

### Arquitectura Interna (Vieja)

```
┌───────────────────────────┐
│  JavaScript Runtime (Hermes/V8) │
│  (Lógica, estado, componentes)  │
├───────────────────────────┤
│      Bridge (Serialización JSON) │  ← CUELLO DE BOTELLA
├───────────────────────────┤
│   Native Thread Pool      │
│   (UIView, Layout, rendering) │
├───────────────────────────┤
│   Hardware                │
└───────────────────────────┘
```

**Problema:** Cada frame, si hay muchos eventos (touch, scroll), se serializa a JSON, cruza el bridge, deserializa, procesa, crea nuevos JSON, devuelve. En listas de 1000 items, esto lagea.

### Arquitectura Interna (Nueva — 2021+)

```
┌──────────────────────────────────────┐
│ JavaScript (Hermes, JSI directo)    │
│ + Native Modules via JSI (no bridge) │
├──────────────────────────────────────┤
│  Fabric (Concurrent Rendering)      │
│  TurboModules (Direct calls)         │
├──────────────────────────────────────┤
│  Native Modules (Kotlin/Swift)       │
├──────────────────────────────────────┤
│  Hardware                            │
└──────────────────────────────────────┘
```

**Mejoras:** JSI elimina serialización para llamadas críticas. Fabric renderiza concurrentemente. Resultado: 60 FPS más consistente.

### Por qué Surgió

**2015:** Facebook creó React Native porque:
1. Reusaba React (web), pero NO quería WebView.
2. Querían UI nativa (performance) pero lógica compartida (productividad).
3. El ecosistema JS era gigante; menos fricción que aprender Swift.

### Fortalezas

1. **Productividad muy alta:** Una base de código para iOS/Android, hot reload, ecosistema npm gigante.
2. **Componentes realmente nativos:** UIView (iOS) y View android, no simulados; performance cercano a nativo.
3. **Ecosistema maduro:** Librerías, comunidad, Stack Overflow.
4. **Company backing:** Meta, Microsoft (ahora), comunidad fuerte.
5. **Nueva arquitectura muy sólida:** JSI y Fabric reducen overhead drásticamente.

### Debilidades Arquitectónicas

1. **Bridge aún existe (versión vieja):** Si usas versión anterior a JSI, el bridge puede ser cuello de botella en escenarios de actualización frecuente (scroll rápido, gestos de tracking).

2. **Interoperabilidad nativa:** Funcionalidades nuevas del SO requieren escribir módulos nativos (en Swift/Kotlin), lo que vuelve a romper la "una base de código".

3. **Debugging complicado:** Breakpoint en JS, pero la app crashea en nativo, requiere entender stacktrace dual.

4. **Tamaño binario:** Sin tree-shaking bien configurado, el runtime JS suma.

5. **Android fragmentación:** Diferentes versiones de RN, diferentes comportamientos por API level.

### Vigencia Actual (2026)

**Muy vigente y creciendo** en:
- Apps de producto con UI moderadamente compleja (no gaming AAA, no AR)
- Equipo pequeño que no pueda mantener dos apps nativas
- Startups que necesitan mercado rápido
- Companies que quieren reutilizar talento JS frontend

**Casos reales exitosos:** Discord (migraron a RN en iOS después), Microsoft Office, Skype, Nike, Shopify.

**Punto crítico:** Con la nueva arquitectura (2021+), el gap de performance con nativo se redujo significativamente.

---

## 4. Motor de Renderizado Propio (Flutter como caso principal)

### Definición
La aplicación controla completamente el pipeline de renderizado: layout, pintura, composición. No delega a widgets nativos del SO.

### Stack Tecnológico

**Flutter (Google, 2017+)**
- **Lenguaje:** Dart (compilado AOT a x86/ARM64)
- **Motor de render:** Skia históricamente (2017-2023), evolución a Impeller (2023+) en iOS/Android
- **Framework:** Widgets declarativos reactivos, arquitectura similar a React pero compilado
- **Compilación:** 
  - Debug: JIT con hot reload
  - Release: AOT compilation → código máquina directo

### Arquitectura Interna

```
┌─────────────────────────────────┐
│   Flutter App (Dart)            │
│   (Widgets, Business Logic)     │
├─────────────────────────────────┤
│   Framework (Reconciliación)    │
│   (Widget tree → Element tree)  │
├─────────────────────────────────┤
│   Rendering Engine (Semantic layer) │
├─────────────────────────────────┤
│   Skia/Impeller (GPU commands)  │
├─────────────────────────────────┤
│   Vulkan/Metal/OpenGL           │
├─────────────────────────────────┤
│   Hardware (GPU/CPU)            │
└─────────────────────────────────┘
```

**Clave:** Flutter **dibuja todo su propio UI**, no reutiliza UIView/View android.

### Por qué Surgió

**2015-2017:** Google buscaba un framework que:
1. No dependiera del WebView (Chromium muy lento en Android hace 10 años)
2. Permitiera UI pixel-perfect sin depender de componentes native
3. Compilara a código máquina real (no JIT variable)
4. Permitiera animaciones complejas sin jank

### Fortalezas

1. **Consistencia visual:** Misma UI en iOS y Android, pixel-perfect, sin sorpresas de componentes nativos distintos.

2. **Animaciones fluidas:** Control total del frame timing, 120 FPS posible sin problema.

3. **Hot reload/rebuild:** Desarrollo muy rápido, feedback inmediato.

4. **Compilación AOT:** Código máquina directo, sin JIT pauses.

5. **Bajo consumo de memoria:** Dart es muy eficiente, no lleva runtime gigante como V8.

6. **Ecosistema creciente:** pub.dev, comunidad fuerte, Google backing.

### Debilidades Arquitectónicas

1. **Motor propio = tamaño binario más grande:** Una app Flutter vacía es ~15 MB (Swift/Kotlin puro ~5 MB).

2. **Integración nativa más compleja:** APIs nuevas del SO requieren platform channels (plugin Dart→Kotlin/Swift), similar a RN pero con sintaxis distinta.

3. **Componentes "custom" vs nativos:** Los Material Design widgets son hermosos, pero no son exactamente los iOS/Android nativos. Requiere Material Design 3 o Cupertino (iOS-like) en la app.

4. **Menos librerías que JavaScript:** pub.dev < npm. Para casos muy especializados, hay menos opciones.

5. **AR/XR aún en plugin:** Impeller mejora rendering, pero AR/XR compleja sigue requiriendo integración nativa o motor externo (Unity).

### Vigencia Actual (2026)

**Muy vigente y creciendo agresivamente** en:
- Apps de UI compleja con animaciones (fintech, e-commerce, social media)
- Equipos que priorizan "misma experiencia en iOS/Android"
- Productos que cambian UI frecuentemente (startup iterativas)
- Wearables (Watch OS, Wear OS)

**Casos reales exitosos:** Google Ads, Alibaba, Nubank, BMW, eBay Motors.

**Google lo posiciona como futuro:** en 2023 deprecó WebView híbridos en favor de Flutter para Google Play promotions.

---

## 5. Futuro: Foldables, AR/XR y Wearables

### Foldables (Pantallas plegables)

#### El Desafío Arquitectónico

Una app en teléfono plegado tiene ~6" con ratio 21:9. Desplegado, ~8" con ratio 17:9. El cambio ocurre en **milisegundos**. Arquitectura tradicional falla:

- If the app caches layout, se vuelve inútil
- If the app reinicia, pierde estado y scroll position
- If the app tries to adapt mid-frame, es jank

#### Qué Demanda

1. **State Management reactivo total:** Cambio de tamaño → el estado UI debe adaptar sin reinicio, sin pérdida de datos, sin visualmente "saltar"

2. **Navigation multi-window:** Dos fragmentos de app en paralelo (lado-a-lado en multi-window mode)

3. **Hinge awareness:** Detectar si hinge está en medio del viewport (que ese píxel es negro, no clickeable)

4. **Gesture handling adaptativo:** Los gestos edge swipe cambian según postura

#### Quién Aguanta Qué

| Tecnología | Soporte Actual | Calidad |
|---|---|---|
| **Nativo** | Perfecto (API oficial FoldingFeature) | ✓✓✓ |
| **Flutter** | Bueno (plugin foldable_display_interface) | ✓✓ |
| **React Native** | Limitado, requiere módulo custom | ✓ |
| **WebView** | Muy limitado, CSS media queries insuficientes | ✗ |

### AR/XR (Realidad Aumentada/Extendida)

#### El Desafío Arquitectónico

AR no solo es "overlay de 2D sobre cámara". Es:
- Tracking espacial en tiempo real (6-DOF)
- Rendering de 3D que ocluye realidad
- Interacción gesture → objeto 3D → physics
- Latencia < 50 ms para no producir cyber-sickness

#### Qué Demanda

1. **Engine 3D completo:** No el canvas 2D de Flutter/RN, sino un motor de física, shaders, LOD culling

2. **Direct GPU access:** Sin abstracciones, puro Metal/Vulkan

3. **IMU sensor fusion:** Giroscopio + acelerómetro + magnetómetro + cámara sincronizados a nivel OS

4. **Low-level threading:** Separar physics thread, render thread, sensor thread sin jitter

#### Quién Aguanta Qué

| Tecnología | Soporte | Método |
|---|---|---|
| **Nativo** | Sí, perfecto | ARKit (iOS) / ARCore (Android) directamente |
| **Flutter** | Parcial + integración | Usar Google ARCore interop, o plugins limitados |
| **React Native** | Parcial + integración | Usar ARKit/ARCore modules, pero overhead del bridge |
| **WebView** | No | WebXR en navegador es muy experimental, app-side no viable |
| **Unity/Unreal** | Excelente | Engine 3D diseñado para esto |

**Conclusión:** AR empresarial o avanzada requiere nativo directo o Unity/Unreal.

### Wearables (Smartwatches, AR glasses)

#### Constraints Especiales

1. **Energía limitada:** Batería se agota en horas, no días
2. **Pantalla pequeña:** 1.4", interfaz minimizada
3. **CPU débil:** Snapdragon 4100+ (2021) aún es less powerful que smartphone 2018
4. **Conexión:** Muchas veces vía Bluetooth a teléfono; app desconexión-resilient

#### Quién Aguanta Qué

| Tecnología | Soporte | Realidad |
|---|---|---|
| **Nativo** | Sí (Wear OS 3, watchOS 9) | ✓ oficial, óptimo energéticamente |
| **Flutter** | Sí, pero genera heat | ⚠ funciona, pero battery drain |
| **React Native** | Limitado | ✗ overhead de bridge inviable en wearable |
| **WebView** | No | ✗ WebView en wearable impensable |

---

## Síntesis: Relevancia 2026

| **Paradigma** | **Cuándo Usar** | **Vigencia** |
|---|---|---|
| **Nativo** | Máxima exigencia: AR, foldables, banca crítica, gaming AAA | ↑ Creciendo |
| **WebView/Híbrido** | MVP rápido, app interna, bajo presupuesto | ↓ Declina |
| **React Native (moderna)** | UI moderada, equipo JS, time-to-market | → Estable, maduro |
| **Flutter** | UI rica, animaciones, consistencia cross-platform | ↑ Creciendo rápido |

---

## Pregunta Clave: ¿Qué es un Aplicativo Nativo? Clasificación

### Definición
Un **aplicativo nativo** es software construido con herramientas, lenguajes y APIs oficiales de una plataforma específica, que compila/ejecuta directamente sobre el runtime native de ese SO, sin capas intermedias de traducción.

### Tipos de Aplicativos Nativos

#### Por Plataforma
- **iOS nativo:** Swift/Objective-C → compila a ARM64 → Metal + Cocoa Touch
- **Android nativo:** Kotlin/Java → JVM bytecode → ART (estático/dinámico) → código máquina
- **Windows nativo:** C#/.NET → CLR / C++ → MSVC
- **macOS nativo:** Swift/Objective-C via Cocoa, similar a iOS

#### Por Nivel de Acceso al Sistema
1. **Nativo puro:** Acceso total a hardware, APIs privadas, bajo-nivel. Ej: un sistema de cámaras profesional en iOS
2. **Nativo con sandboxing:** Acceso restringido por OS, APIs públicas only. Ej: 99% de apps en App Store
3. **Nativo con JIT/runtime:** Técnicamente ejecuta código compilado pero sobre un runtime administrado (Java en Android ART). Sigue considerándose nativo porque es el stack oficial.

#### Por Arquitectura del Código
- **Monolítico:** Todo el código en una app única
- **Modular:** Componentes, módulos reutilizables, pero una app principal
- **Multi-layered:** Presentación → lógica → datos → BD, clara separación

### Cross-Platform vs Nativo
| Término | Definición | App |
|---|---|---|
| **Nativo** | Construida con herramientas oficiales SO | Swift/Kotlin |
| **Cross-platform** | Construida en una abstracción, genera múltiples targets | React Native, Flutter |
| **Pseudo-nativo** | Abstracción pero UI mapping a componentes nativos | React Native antiguo |
| **No-nativo** | UI propia, no delega SO | Flutter, WebView |

---

## References y Fuentes

- Apple Developer: Swift, ARKit 6, Multi-window support
- Google Developer: Kotlin, Jetpack Compose, ARCore, Foldable Support
- Meta/RN: React Native Architecture 2021+, JSI, Fabric
- Google Flutter: Fiber architecture, Impeller rendering engine
- ARCore + ARKit documentation: Latency budgets, tracking, occlusion
- Nubank engineering blog: Flutter at scale
- Discord engineering: RN production lessons

