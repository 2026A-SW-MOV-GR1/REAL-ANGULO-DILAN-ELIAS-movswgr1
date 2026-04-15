# Matriz Comparativa Arquitectónica: Decisión Tecnológica

**Grupo:** Dilan Elías Angulo y Melany Lema  
**Casos de Estudio:** Airbnb vs Spotify  
**Propósito:** Usar esta matriz para fundamentar por qué cada compañía eligió su arquitectura

---

## 1. Matriz Maestra de Comparación

| **Criterio** | **Nativo** | **WebView/Híbrido** | **React Native** | **Flutter** |
|---|---|---|---|---|
| **Rendimiento UI (FPS)** | 60-120 estable | 30-45 (scroll laggy) | 60 (Arch moderna) | 60-120 estable |
| **Startup time** | 800ms-2s | 2-5s (WebView boot) | 1.5-3s | 1.5-3s |
| **Memory footprint** | 100-150 MB (app running) | 80-120 MB + WebView | 150-200 MB (JS runtime) | 120-180 MB (Dart + engine) |
| **Tamaño binario (vacío)** | 5-8 MB | 2-3 MB | 30-50 MB | 15-25 MB |
| **Compilación (Debug)** | Xcode/Android Studio: 1-3 min | Gradlew: 1-2 min | Metro bundler: 10-30s | Dart compilation: 10-20s |
| **Hot reload?** | Xcode preview (iOS 15+) | No real | Sí (JS) | Sí (Dart) |
| **Curva de aprendizaje** | Muy alta (Swift/Kotlin) | Baja (Web dev) | Media (React + nativo) | Media (Dart + widgets) |
| **Time to market** | Lento (dos codebases) | Muy rápido | Rápido | Rápido |
| **Costo inicial (equipo)** | Alto (2 equipos especializados) | Bajo (1 web team) | Medio (1 equipo JS) | Medio (1 equipo Dart) |
| **Mantenimiento** | Duplicación de features | Una base de código | Una lógica, UI nativa | Una base de código |
| **Acceso a hardware** | 100% (todas las APIs) | 0-10% (via plugins) | 70% (via modules + bridge) | 60-80% (via platform channels) |
| **Latencia hardware** | < 10 ms | 50-200 ms (bridge) | 10-50 ms (JSI reducido) | 10-50 ms (channel overhead) |
| **Testing** | Unitario (XCTest/JUnit) + UI testing | Selenium-like diffícil | Jest/Vitest en lógica | flutter test sólido |
| **Deep linking** | Nativo, confiable | Depende plugin | RN community linking sólido | Deprecated problem (mejorado 3.x) |
| **Font rasterization** | Nativo exacto | Sistema webkit | Mapping a native fonts | Skia renderiza todo |
| **Actualizaciones OTA** | CodePush (beta MS) | js bundle swap trivial | CodePush maduro | Shorebird (emergente) |
| **SEO/Indexación** | No aplicable | Indexable por crawler | No (app nativa) | No (app nativa) |
| **Fragmentación (Android)** | Alto impacto | WebView variado (mejor en 10+) | ART consistente, pero gama baja lag | Menos (motor propio) |
| **Soporte Foldables** | ✓ Oficial (FoldingFeature API) | ✗ CSS media queries insuficientes | ⚠ Custom modules requerido | ✓ foldable_display plugin |
| **Soporte AR avanzada** | ✓✓✓ (ARKit/ARCore óptimo) | ✗ (WebXR no viables) | ⚠ (bridge overhead notable) | ⚠ (integración nativa requerida) |
| **Soporte Wearables** | ✓ Oficial | ✗ Impensable | ✗ Battery drain | ⚠ Funciona, consume + energía |
| **Madurez en prod** | 15+ años | 10+ años pero decayendo | 8 años, sólida | 6 años, muy sólida |
| **Comunidad** | Oficial, fragmentada iOS/Android | Pequeña, legacy | Masiva (Meta backing) | Grande (Google backing) |

---

## 2. Deep Dive: Rendimiento (Frame Detailing)

### Ciclo de Render: 16.67ms @ 60 FPS

#### Nativo (iOS UIKit/SwiftUI)
```
[0ms]    Touch event
[0.5ms]  Gesture recognizer
[1ms]    View hierarchy update
[2ms]    Layout pass (AUTO layout)
[3ms]    Render pass (CAMetalLayer command buffer)
[4ms]    Compositor (prepare GPU commands)
[5ms]    GPU rendering
[10ms]   < Frame ready
[16.67ms] VSYNC: Display flips
```
**Resultado:** 60 FPS consistent, GPU saturation predictable

#### React Native (Vieja arquitectura)
```
[0ms]    Touch event (native thread)
[0.5ms]  → Serialize to JSON
[1ms]    → Pass through bridge queue (mutex wait)
[2ms]    ← JS thread receives event
[3ms]    ← JavaScript handler logic
[4ms]    ← Create new layout props
[5ms]    ← Serialize back to JSON
[6ms]    → Pass through bridge
[8ms]    ← Native thread receives, layout
[10ms]   Render pass
[12ms]   GPU rendering
[16.67ms] VSYNC: Display flips (IF timing lucky)
```
**Resultado:** 50-55 FPS en listas de 100+ items due to bridge congestion

#### React Native (Nueva arquitectura JSI)
```
[0ms]    Touch event
[0.5ms]  → Direct call via JSI (no serialization)
[1.5ms]  ← JavaScript handler
[2.5ms]  ← Direct native call (no bridge)
[3.5ms]  Native layout + GPU
[5ms]    < Frame ready
[16.67ms] VSYNC successful
```
**Resultado:** 60 FPS, similar a nativo

#### Flutter
```
[0ms]    Touch event (platform channel)
[0.5ms]  → Dart handler
[1.5ms]  ← Widget tree reconciliation
[2.5ms]  ← Render object paint
[3ms]    Skia command buffer
[4ms]    GPU (Metal/Vulkan)
[6ms]    < Frame ready
[16.67ms] VSYNC successful
```
**Resultado:** 60-120 FPS (Impeller engine 2023+)

#### WebView Híbrido
```
[0ms]    Touch event
[1ms]    → JavaScript event handler
[2ms]    ← DOM invalidation
[3-8ms]  WebKit render tree rebuild (complex CSS)
[9ms]    Composite layers
[10-12ms] GPU upload
[16.67ms] VSYNC: Mayormente se pierde
```
**Resultado:** 30-45 FPS, perceptible jank

---

## 3. Matriz: Acceso a Hardware

| **Capacidad** | **Nativo** | **RN** | **Flutter** | **Híbrido** |
|---|---|---|---|---|
| GPS | ✓ Direct | ✓ (module) | ✓ (plugin) | ✓ (plugin) |
| Camera (básica) | ✓ Direct | ✓ (module) | ✓ (plugin) | ✓ (plugin) |
| Camera (RAW) | ✓ AVCaptureDevice | ✗ | ✗ (deprec plugin) | ✗ |
| Bluetooth LE | ✓ Direct | ✓ (BLE module) | ✓ (ble plugin) | ✗ Rarely |
| NFC | ✓ Direct | ✓ (react-native-nfc) | ✓ (nfc plugin) | Partial |
| Biometry (Face/Fingerprint) | ✓ Direct | ✓ (RN Biometrics) | ✓ (local_auth) | Partial |
| Health Kit / Health Connect | ✓ Direct (iOS/Android 6.0+) | ✓ (module) | ✓ (plugin) | ✗ |
| LiDAR | ✓ (iOS 12+) | ✗ | ✗ | ✗ |
| ARKit/ARCore | ✓ Direct | ⚠ (ARCore interop + overhead) | ⚠ (plugin + integración) | ✗ |
| Secure Enclave / TEE | ✓ Direct | ✓ (RN Keychain) | ✓ (flutter_secure) | Partial |
| Notifications (Push) | ✓ Direct | ✓ (Firebase) | ✓ (Firebase) | ✓ (Firebase) |
| Widget/App Clip | ✓ (iOS) | ✗ Custom native | ✗ Depende | ✗ |
| Background Processing | ✓ Direct | ⚠ Limited | ⚠ Limited | ✗ |

**Clave:** Nativo = 100%. Otros requieren módulos; si no existe, 12-16 semanas de engineering.

---

## 4. Matriz: Casos de Uso y Fit Architectónico

| **Escenario** | **Mejor Opción** | **2ª Opción** | **Evitar** |
|---|---|---|---|
| **Banca de transacciones críticas** | Nativo | Flutter | Híbrido, RN |
| **Social media feed (scroll mil items)** | Nativo, Flutter | RN moderno | Híbrido |
| **E-commerce/catálogo** | Flutter, RN | Nativo | Híbrido (acceptable) |
| **App de notas simple (todo)** | Cualquiera | | |
| **Gaming casual 2D** | Flutter, Nativo | RN | Híbrido |
| **Gaming 3D AAA** | Nativo (Unity/Unreal) | | Flutter, RN |
| **AR experiencial** | Nativo (ARKit/ARCore) + engine | Unity | Flutter, RN, Híbrido |
| **Video en tiempo real (conferencia)** | Nativo | RN (webrtc module) | Híbrido |
| **Foldables sin concesiones** | Nativo | Flutter | RN, Híbrido |
| **Wearable smartwatch** | Nativo (Wear OS/watchOS) | Flutter | RN, Híbrido |
| **MVP rápido de startup** | RN, Flutter, Híbrido | | Nativo (lento) |
| **App migrada de web** | RN, Flutter | Nativo | Híbrido (corto plazo) |

---

## 5. Curvas de Costo Total (TCO) en el Tiempo

### Año 1: Desarrollo inicial

```
NATIVO:        Cost = 2x (dos equipos)
RN/FLUTTER:    Cost = 1x (un equipo)
HÍBRIDO:       Cost = 0.8x (web team)
```

### Año 2-3: Feature velocity + bugs

```
NATIVO:        Cost = 1.5x (duplo mantenimiento, pero equipos especializados conocen bien)
RN:            Cost = 0.9x (una base de código, pero bridge issues emergen)
FLUTTER:       Cost = 0.85x (muy rápido, ecosistema creciente)
HÍBRIDO:       Cost = 1.5x (WebView updates break compatibility)
```

### Año 5+: Madurez y deuda técnica

```
NATIVO:        Cost = 1.2x (estable, bugfixes oficiales)
RN:            Cost = 1.3x (deuda técnica: bridge calls, modules custom)
FLUTTER:       Cost = 0.8x (sigue siendo rápido)
HÍBRIDO:       Cost = 2x (completamente deprecada, migraciones fuerza)
```

**Conclusión:** Cross-platform (RN/Flutter) gana en corto-medio plazo. Nativo es mejor en largo plazo si UI es crítica.

---

## 6. Risk Matrix: Escenarios de Riesgo Técnico

| **Riesgo** | **Probabilidad (2026)** | **Impacto** | **Mitigación** |
|---|---|---|---|
| Apple cambia API crítica (p.ej. privacy) | Alto | Alto | Nativo sigue oficial; RN/Flutter espera a plugin |
| Google depreca Android Java/Go | Bajo | Medio | Kotlin bien soportado; ambos cross-platform aguantan |
| Apple depreca WebView | Muy alto | Crítico (para híbrido) | Híbrido muere; migrar a RN/Flutter urgente |
| Microsoft abandona React Native | Bajo (backing fuerte) | Medio | Comunidad es gigante; Meta aún interesada |
| Google depreca Flutter | Muy bajo (prioridad) | Bajo | Comunidad open source continuaría |
| Chipset fabricante cambia GPU | Muy bajo | Bajo | Abstracción de SO maneja |
| Foldable becomes mainstream | Bajo | Medio | Nativo y Flutter ready; RN requiere engineering |
| AR becomes mandatory on flagships | Bajo-medio | Alto | Nativo y Unity best; RN/Flutter need modules |

---

## 7. Escalabilidad: Teoría de Límites de Crecimiento

### Escenario: App con millones de usuarios

**Nativo:**
- Backend: Sin limitación
- Frontend: UI responsivo si código bien, pero duplicación mantiene costo alto
- Versiones antiguas: Necesario soportar iOS 12 (2% usuarios), Android 8+ (0.1% usuarios)

**React Native (moderna):**
- Backend: Sin limitación
- Frontend: Fabric + JSI permite scales bien
- **Limiting factor:** Módulos nativos; si necesitas feature exótica cada 6 meses, deuda acumula

**Flutter:**
- Backend: Sin limitación
- Frontend: Motor propio aguanta animaciones sin problema
- **Limiting factor:** Integración nativa complicada (menos plugins que RN), pero sigue siendo viable

**Híbrido:**
- Backend: Sin limitación
- Frontend: WebView falla en UX premium
- **Limiting factor:** Migración forzada

---

## 8. Preguntas de Decisión Crítica (Para tu Análisis Airbnb/Spotify)

1. **¿Cuántos usuarios target?**
   - < 100k: Cualquiera
   - 100k-5M: RN/Flutter preferible
   - 5M+: Nativo o Flutter + arquitectura escalable

2. **¿Cuál es el 95p latency requerido para interacción crítica?**
   - < 50ms: Nativo
   - 50-100ms: RN moderno o Flutter
   - 100-200ms: Híbrido aceptable

3. **¿Necesitas nuevo hardware feature en próximos 18 meses?**
   - Sí (AR, foldables, health sensors): Nativo o Flutter + módulos custom
   - No claro todavía: RN es safe bet

4. **¿Tienes talento disponible?**
   - Swift/Kotlin: Nativo
   - JavaScript: RN
   - Dart: Flutter
   - HTML/CSS/JS: Híbrido (o migrar a RN)

5. **¿El producto es UI-heavy o logic-heavy?**
   - UI heavy (animar, scroll, gestures): Flutter, RN moderno
   - Logic heavy (cálculos, APIs): Nativo (control fino), RN, Flutter

---

## References

- Flutter Performance (2023): https://flutter.dev/docs/perf
- React Native Architecture (2021+): JSI, Fabric, TurboModules
- Nubank: "Flutter App Development" (engineering case study)
- Discord: "RN at scale and Android multiplatform"
- Airbnb: "Why Airbnb Deprecated React Native" (Feb 2018, pero contexto pre-JSI)
- Spotify: Closed ecosystem, hybrid native approach

