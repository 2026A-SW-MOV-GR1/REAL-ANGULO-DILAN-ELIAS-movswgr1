# Glosario Técnico: Términos Clave para Defensa Oral

**Grupo:** Dilan Elías Angulo y Melany Lema  
**Propósito:** Definiciones precisas para no sonar vago/genérico en clase

---

## A

### AOT (Ahead-of-Time Compilation)
**Definición:** Compilar código a código máquina **antes** de que se ejecute.

**Implicación arquitectónica:**
- Se hace en build-time
- Resultado: Ejecutable directo, sin pauses de compilación JIT
- Usado en: Flutter (Dart AOT), iOS nativo (Swift compiler), Android release builds (R8/ProGuard)
- Ventaja: Predecible, sin sorpresas en runtime
- Desventaja: Build time más largo

**Ejemplo opuesto (JIT):** JavaScript en React Native se interpreta/compila en runtime; si necesitas feature nueva, el motor lo compila on-the-fly (microlags).

---

## B

### Bridge (en Cross-Platform)
**Definición:** Capa de comunicación que traduce entre JavaScript/Dart y código nativo.

**Cómo funciona:**
```
JavaScript (app logic)
         ↓ [SERIALIZE to JSON]
      BRIDGE
         ↓ [DESERIALIZE]
Native Code (kernel API call)
```

**Problemas:**
1. **Serialización:** Convertir objetos JS a JSON toma tiempo (~2-5ms per call)
2. **Cuello de botella:** Si scroll de 1000 items dispara 1000 bridge calls, lag
3. **Sincronía:** JavaScript espera respuesta nativa; si tarda, congela el thread

**Evolucionado en:** React Native 2021+ usa JSI (elimina JSON serialization)

---

## C

### Cyber-sickness
**Definición:** Mareo/nausea causado por discrepancia entre movimiento visual y movimiento del sistema vestibular (equilibrio).

**Requisito técnico:** Latencia < 50ms entre detectar movimiento de cabeza y actualizar pantalla.

**Implicación:** AR/XR requiere arquitectura de ultra-baja latencia; cross-platform con overhead no puede garantizarlo.

---

## D

### Dart
**Definición:** Lenguaje compilado (AOT) creado por Google. Motor de Flutter.

**Características:**
- Tipado estático (2.0+)
- Null-safe (2.12+)
- Garbage collection automático
- Compilación a código máquina ARM64/x86

**Ventaja vs JavaScript:** Compilado a máquina real; sin sorpresas de runtime.

---

## E

### Event Loop (Bridge congestion)
**Definición:** Mecanismo de OS que encola eventos (toques, gestos) para procesar secuencialmente.

**En React Native viejo:**
```
Touch event → JavaScript event listener
     ↓
Update state
     ↓ [SERIALIZE to JSON]
BRIDGE QUEUE (si muchas updates, espera)
     ↓
Native side procesa
     ↓ [DESERIALIZE]
Update native UI
     ↓
GPU render (si todo sucedió < 16.67ms)
```

**Problema:** Si bridge está atascado, eventos se encolan, UI se ve "laggy"

---

## F

### Fabric (React Native)
**Definición:** Nuevo render engine de React Native (2021+) que permite renderizado concurrente y bajo-overhead.

**Diferencia vs viejo:**
- Viejo: Bridge serialización síncrona
- Fabric: Direct C++ bindings, concurrency support

**Resultado:** Mejor performance en listas largas

---

## G

### Garbage Collection (GC)
**Definición:** Mecanismo automático que libera memoria no usada.

**Tipos:**
- **Mark & Sweep:** Marca objetos usados, borra resto. Stop-the-world (pausa app)
- **Generational:** Asume objetos jóvenes se borran pronto; scan frecuente young gen
- **Concurrent:** GC corre en thread aparte (menos pauses)

**En móvil:**
- iOS: ARC (Automatic Reference Counting, determinístico)
- Android: Concurrent GC (Dalvik hasta Android 5, ART desde 5+)
- Flutter/Dart: GC generacional concurrente

**Problema en UI:** Si GC pausa app > 16.67ms @ 60 FPS, jank visible

---

## H

### Hot Reload / Hot Restart
**Definición:** Actualizar código sin reiniciar app.

**Hot Reload:**
- Mantiene estado de app
- Actualiza solo código modificado
- Usado en: Flutter, React Native (Expo), algunas versiones de Xcode

**Hot Restart:**
- Reinicia app, vuelve a cargar código
- Pierde estado

**Impacto DX:** Feedback < 2s = enormemente más productivo que esperar compilación 2-3 minutos.

---

## I

### IMU (Inertial Measurement Unit)
**Definición:** Sensor que mide aceleración (acelerómetro) y rotación (giroscopio).

**Usado en:**
- Detección de caídas (Apple Fall Detection)
- Tracking de movimiento cabeza en AR/VR
- Sensor de proximity ("está el phone pegado a oreja")

**Latencia crítica:** IMU → fusion → render debe ser < 20ms en AR glasses

---

## J

### JIT (Just-In-Time Compilation)
**Definición:** Compilar código a máquina **mientras está ejecutándose**.

**Implicación:**
- Esperanza: Optimizar hot paths (código ejecutado frecuente)
- Realidad: Micro-pauses cuando compiler activa
- Usado en: JavaScript engines (V8, Hermes), Android ART (modo JIT/AOT híbrido)

**Problema en móvil:** JIT pause puede romper 60 FPS frame budget

---

## K

### Kotlin
**Definición:** Lenguaje de programación compilado (JVM bytecode) para Android. Recomendación oficial desde 2019.

**Ventajas sobre Java:**
- Null-safe sintaxis
- Extension functions
- Coroutines (async/await)
- Compilación más rápida

**Compilación:** Kotlin → bytecode JVM → ART (Android Java runtime) → máquina nativa (JIT/AOT)

---

## L

### Latency Budget
**Definición:** Tiempo máximo permitido para completar una operación sin afectar UX.

**Ejemplos:**
- **60 FPS:** 16.67 ms por frame
- **120 FPS:** 8.3 ms por frame
- **AR/VR perceptual:** < 50 ms (para no producir cyber-sickness)
- **Touch response:** < 100 ms (usuario no lo nota)

**En cross-platform:** Bridge overhead consume latency budget; si overhead > 10ms, frame budget colapsa

---

## M

### MDN (Metal, Vulkan, OpenGL)
**Definición:** APIs de gráficos de bajo nivel para GPU direct access.

**En móvil:**
- **Metal:** Propietaria Apple (iOS/macOS)
- **Vulkan:** Estándar abierto (Android, también Windows)
- **OpenGL ES:** Legacy (deprecated en mobile 2023+)

**Relación con arquitectura:**
- Nativo: Acceso directo a Metal/Vulkan
- Flutter: Skia/Impeller traduce a Metal/Vulkan
- RN: Acceso directo (native modules) o a través de framework (React Native Skia)

### Memory Footprint
**Definición:** Cantidad de RAM usada por aplicación en memoria.

**Típicos (app running):**
- Nativo simple: 50-100 MB
- Flutter app: 100-150 MB (engine payload)
- React Native: 150-200 MB (JS runtime payload)

**Android limite crítico:** Devices con 2 GB RAM (gama baja); apps > 200 MB usan 10% batería solo en memory pressure

---

## N

### Native Bridge (vs Bridge)
**Definición:** En contexto de React Native viejo, se refiere al componente C++ que traduce JS ↔ código nativo.

**No confundir:** Bridge (abstracto) vs Native Bridge (implementación específica de RN)

---

## O

### Occlusion (en AR)
**Definición:** Técnica gráfica donde objeto 3D virtual oculta realidad detrás ( depth buffer).

**Implementación:**
```glsl
// Pseudocode shader
Fragment f = raytrace(pixel);
float depth_virtual = object.depth;
float depth_real = depthMap.sample(uv);

if (depth_virtual < depth_real) {
    // Virtual object is closer, render it
    return virtualColor;
} else {
    // Real world is closer, render camera feed
    return cameraFeed;
}
```

**Requisito:** GPU debe tener Z-buffer de cámara real (ARCore/ARKit)

---

## P

### Platform Channel (Flutter)
**Definición:** Mecanismo Flutter para llamar código nativo (Kotlin/Swift) desde Dart.

**Patrón:**
```dart
// Dart side
const platform = MethodChannel('com.example.app/myChannel');
final String result = await platform.invokeMethod('getNativeValue');
```

```kotlin
// Kotlin side
MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.app/myChannel")
    .setMethodCallHandler { call, result ->
        when (call.method) {
            "getNativeValue" -> result.success("Value from native")
            else -> result.notImplemented()
        }
    }
```

**Latencia:** Serialización similar a RN bridge (~5-10ms)

### Plugin / Module
**Definición:** Código nativo (Kotlin/Swift, C++) empaquetado para ser utilizado desde framework cross-platform.

**Ejemplo:**
- `react-native-camera` = módulo RN que wrapper ARCore/iOS Camera
- `google_maps_flutter` = plugin Flutter que wrapper Google Maps Nativo

---

## Q

### QoS (Quality of Service)
**Definición:** En networking/audio, garantía de delivery/latency.

**Usado en:**
- Llamadas en tiempo real (Discord, Spotify)
- Streaming de video (calidad adaptativa)

**En móvil:** Aplicación debe adaptar a red 4G/5G variable, no asumir stableconstante

---

## R

### Render Pipeline
**Definición:** Secuencia de pasos para convertir estado de app → píxeles en pantalla.

**Pasos típicos:**
1. **Reconciliation:** JavaScript/Dart compara old state vs new state
2. **Layout:** Calcula posiciones y tamaños
3. **Paint:** Genera comandos de render
4. **Composite:** Agrupa layers para GPU
5. **Rasterize & Scan Out:** GPU dibuja, display actualiza

**En nativo:** 1-2ms (très rápido)
**En RN viejo:** 5-10ms (bridge overhead)
**En Flutter:** 2-4ms (todo en Dart/motor propio)

### React Native (RN)
**Definición:** Framework cross-platform que permite escribir apps iOS/Android en JavaScript, con componentes nativos.

**Stack:**
- UI nativa real (no WebView)
- Lógica en JavaScript
- Bridge para comunicación

---

## S

### Skia
**Definición:** Motor de rendering 2D open-source (Google), usado históricamente en Flutter.

**Características:**
- GPU-accelerated
- Canvas API parecida a HTML5 canvas
- Render text, images, vectors
- Multi-platform (Android, iOS, Linux, Windows)

**Evolución:** Flutter está migrando a Impeller (2023+) para mejor performance

### Snapdragon (en wearables/móvil)
**Definición:** Familia de chipsets ARM de Qualcomm.

**Generaciones relevantes:**
- Snapdragon 4100+ (wearables, 2021): 4 cores @ 1.7 GHz
- Snapdragon 8 Gen 3 (flagship 2024): 8 cores @ 3.3 GHz

**Impacto:** Snapdragon débil = cross-platform overhead inaceptable

---

## T

### TurboModules (React Native)
**Definición:** Sistema de módulos nativos modernizado (2021+) que evita overhead de bridge.

**Diferencia vs viejo:**
- Viejo: Module register → lookup → bridge call → JSON serialization
- TurboModules: Direct C++ binding, lazy instantiation

**Resultado:** Performance cercana a JSI

---

## U

### UIKit / SwiftUI (iOS)
**Definición:** Frameworks de UI para iOS.

- **UIKit:** Imperativo, más control bajo-nivel (legacy, aún usado)
- **SwiftUI:** Declarativo, más moderno (2019+)

**Equivalente Android:** View system y Jetpack Compose

---

## V

### Vulkan
**Definición:** API gráfica cross-platform de bajo nivel (successor a OpenGL).

**Características:**
- Menos overhead que OpenGL
- Multi-threading support
- Android official 2016+
- También windows/Linux

**Usado en:** Android nativo, algunos apps gaming

---

## W

### WebView
**Definición:** Navegador embebido que ejecuta HTML/CSS/JavaScript dentro de app nativa.

**Variantes:**
- Android WebView (Chromium-based desde Android 5)
- iOS UIWebView (deprecated iOS 12+), WKWebView (recomendado)

**Performance:** 30-45 FPS en scroll (vs 60 nativo)

---

## X

### XR / Extended Reality
**Definición:** Término paraguas para AR, VR, MR (Mixed Reality).

**Diferencias:**
- **VR:** Full immersive (headset, outside world blocked)
- **AR:** Overlay con realidad visible
- **MR:** Occlusion real (objeto virtual interactúa con realidad)

**Implicación arquitectónica:** Todas requieren nativo + engine 3D

---

## Y

### Yield / Context Switch
**Definición:** Ceder control del thread a otro thread/proceso.

**En UI thread:**
```
[0ms] Touch event processing
[5ms] App state update
[10ms] Re-render
[15ms] YIELD: Permite OS procesar otros eventos
[16.67ms] VSYNC: Display actualiza
```

**Problema:** Si app NO cede, OS fuerza yield (lag) o kill app (ANR en Android)

---

## Z

### ZERO-COPY / Direct Memory Access (DMA)
**Definición:** Transferir datos entre hardware sin pasar por CPU.

**En GPU:** Texture upload sin copia intermedia en CPU → GPU memory faster

**Relevancia:** Nativo permite DMA; cross-platform frameworks abstraen, hay overhead

---

## Acronyms Quick Reference

| **Sigla** | **Significado** | **Contexto** |
|---|---|---|
| **AOT** | Ahead-of-Time | Flutter, Dart, compilación |
| **ART** | Android Runtime | Android 5+, ejecución app |
| **JIT** | Just-In-Time | JavaScript, compilación runtime |
| **GC** | Garbage Collection | Manejo de memoria automático |
| **FPS** | Frames Per Second | Performance UI |
| **GPU** | Graphics Processing Unit | Renderizado |
| **IMU** | Inertial Measurement Unit | Sensores de movimiento |
| **AR/VR/XR** | Augmented/Virtual/Extended Reality | Interfaces futuro |
| **SDK** | Software Development Kit | Herramientas de desarrollo |
| **API** | Application Programming Interface | Interface entre componentes |
| **OTA** | Over-the-Air | Actualización remota |
| **TEE** | Trusted Execution Environment | Secure Enclave (Apple), Knox (Samsung) |
| **HTML5** | Hypertext Markup Language versión 5 | Web platform |

---

## Frases Clave para Memorizar (y no sonar genérico)

1. **"El bridge es un cuello de botella en escenarios de alto tráfico de eventos"** → Correcto si hablas de RN viejo
2. **"Fabric y JSI redujeron significativamente el overhead del bridge"** → Muestra que conoces evolución
3. **"Flutter controla todo el pipeline de renderizado"** → Explica quién gana en animaciones complejas
4. **"Cyber-sickness ocurre si latencia > 50ms"** → Requisito concreto para AR
5. **"Nativo aguanta AR; cross-platform requiere integración nativa anyway"** → Conclusión pragmática
6. **"Foldables requieren state management reactivo total"** → No es solo "responsive design"
7. **"AOT compilation elimina JIT micro-pauses"** → Advantage Flutter vs RN
8. **"Platform channels tienen overhead de serialización similar al bridge viejo"** → Honest assessment Flutter

