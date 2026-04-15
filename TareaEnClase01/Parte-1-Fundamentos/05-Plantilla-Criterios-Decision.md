# Plantilla de Criterios de Decisión Arquitectónica

**Grupo:** Dilan Elías Angulo y Melany Lema  
**Propósito:** Framework para defender "por qué" una app eligió su arquitectura (nativo vs cross-platform)

---

## Checklist Maestra: Decisión de Tecnología

Para cada característica de la app, asigna puntos:
- ✓ = La tecnología cumple muy bien
- ~ = La tecnología cumple aceptablemente
- ✗ = La tecnología NO cumple o es muy difícil

---

## 1. Requisitos de Negocio

### 1.1 Velocidad de Mercado
```
Pregunta: ¿Cuánto tiempo tienes para llegar al mercado?

[ ] < 3 meses:
    Nativo: ✗ (dos equipos = lento)
    RN/Flutter: ✓ (rápido, una base de código)
    Híbrido: ✓✓ (MAS rápido, pero UX baja)
    
[ ] 3-6 meses:
    Nativo: ~ (si equipo experto)
    RN/Flutter: ✓
    
[ ] > 6 meses:
    Nativo: ✓ (máxima calidad)
    RN/Flutter: ✓ (igual calidad)
```

### 1.2 Presupuesto de Desarrollo
```
Pregunta: ¿Cuál es el presupuesto inicial?

[ ] Muy limitado (startup MVP):
    Nativo: ✗ (muy caro)
    RN/Flutter: ✓
    Híbrido: ✓✓
    
[ ] Moderado (Series A-B):
    Nativo: ~ (posible con dos equipos)
    RN/Flutter: ✓✓
    
[ ] Sin limitación (FAANG):
    Nativo: ✓✓ (por qué no)
    RN/Flutter: ✓ (también opcion)
```

### 1.3 Escala de Usuarios
```
Pregunta: ¿Cuántos usuarios esperados en Y1?

[ ] 0-100k:
    Todas las opciones viables
    
[ ] 100k-10M:
    Nativo: ✓ (escalable)
    RN moderno: ✓ (escalable con Fabric)
    Flutter: ✓✓ (motor propio, escalable)
    
[ ] 10M+:
    Nativo: ✓ (mejor optimización)
    RN/Flutter: ✓ (pero require fine-tuning)
```

### 1.4 Ciclo de Feature Release
```
Pregunta: ¿Frecuencia de nuevos features?

[ ] Semanal:
    RN/Flutter: ✓✓ (hot reload, fast iteration)
    Nativo: ~ (compilación + App Review delays)
    
[ ] Mensual:
    Todas igual
    
[ ] Trimestral o más:
    Nativo: ✓ (calidad > velocidad)
```

---

## 2. Requisitos Técnicos

### 2.1 Rendimiento UI
```
Pregunta: ¿Cuál es tu frame rate mínimo aceptable?

[ ] 30-45 FPS (OK):
    Nativo: ✓
    Float: ✓
    RN: ✓ (moderno)
    Híbrido: ~ (suficiente)
    
[ ] 60 FPS (Standard):
    Nativo: ✓✓
    Flutter: ✓✓
    RN: ✓ (con Fabric)
    Híbrido: ✗
    
[ ] 120 FPS o más:
    Nativo: ✓
    Flutter: ✓ (Impeller 2023+)
    RN: ~ (posible pero difícil)
    Híbrido: ✗
```

### 2.2 Latencia de Respuesta
```
Pregunta: ¿Cuál es latencia máxima aceptable?

[ ] 100-200 ms (OK, imperceptible en mayoría casos):
    Todas
    
[ ] 50-100 ms (Crítico, touch tracking):
    Nativo: ✓✓
    Flutter: ✓
    RN: ✓ (JSI moderno)
    Híbrido: ✗
    
[ ] < 50 ms (AR/VR, cyber-sickness threshold):
    Nativo: ✓✓
    Flutter: ✓ (con integración nativa AR)
    RN: ~ (bridge overhead notable)
    Híbrido: ✗
```

### 2.3 Consumo de Memoria
```
Pregunta: ¿Device mínimo target?

[ ] 4 GB RAM o superior (flagship):
    Todas
    
[ ] 2-4 GB RAM (mid-range):
    Nativo: ✓ (50-100 MB)
    Flutter: ✓ (100-150 MB)
    RN: ~ (150-200 MB, borde crítico)
    Híbrido: ✓
    
[ ] 1-2 GB RAM (budget/entrada):
    Nativo: ✓
    Híbrido: ✓
    Flutter: ✗ (payload demasiado)
    RN: ✗
```

### 2.4 Tamaño de App
```
Pregunta: ¿App size límite?

[ ] < 30 MB:
    Nativo: ✓✓
    Híbrido: ✓✓
    RN: ~ (30-50 MB típico)
    Flutter: ~ (15-25 MB típico)
    
[ ] < 50 MB:
    Nativo: ✓
    Híbrido: ✓
    RN: ✓
    Flutter: ✓
    
[ ] Sin límite (> 100 MB OK):
    Todas
```

### 2.5 Acceso a Hardware Crítico
```
Pregunta: ¿Necesitas APIs de hardware nuevas?

[ ] APIs estándar (GPS, camera, notificaciones):
    Todas (✓)
    
[ ] APIs avanzadas (LiDAR, NFC, Health Kit):
    Nativo: ✓✓
    RN/Flutter: ✓ (si plugin existe)
    Híbrido: ✗
    
[ ] APIs no-existen todavía (future devices):
    Nativo: ✓ (primera opción)
    RN/Flutter: ✗ (depende de plugin community)
```

### 2.6 Seguridad Crítica
```
Pregunta: ¿Necesitas encriptación de alto nivel?

[ ] Standard (OAuth, HTTPS, tokens):
    Todas
    
[ ] Crítica (transacciones bancarias, biometría):
    Nativo: ✓✓ (Secure Enclave direct)
    RN/Flutter: ✓ (via modules, pero añade complejidad)
    Híbrido: ✗
```

---

## 3. Requisitos de Contenido/Dominio

### 3.1 Naturaleza del Contenido
```
Pregunta: ¿Qué tipo de contenido?

[ ] Basado en texto/lectura (news, social feed):
    Nativo: ✓
    Flutter: ✓
    RN: ✓
    Híbrido: ~ (WebView feels clunky)
    
[ ] Altamente visual/animaciones (e-commerce, photo app):
    Nativo: ✓
    Flutter: ✓✓
    RN: ✓
    Híbrido: ✗
    
[ ] 3D/Graphics intensiva (GPS maps, gaming):
    Nativo: ✓✓
    Flutter: ✓ (si maps plugin ok)
    RN: ✓ (si Google Maps module ok)
    Hybrid: ✗
    
[ ] Tiempo real / streaming (video call, music):
    Nativo: ✓✓
    Flutter: ✓
    RN: ✓ (WebRTC modules disponibles)
    Hybrid: ✗
```

### 3.2 Interactividad con Gráficos
```
Pregunta: ¿Necesitas manipular gráficos 3D?

[ ] No (2D UI nada más):
    Todas
    
[ ] Sí, pero stándar (Google Maps, AR preview):
    Nativo: ✓✓
    Flutter: ✓ (google_maps_flutter plugin)
    RN: ✓ (react-native-maps module)
    Hybrid: ✗
    
[ ] Sí, complejo (AR/VR avanzado, rendering custom):
    Nativo: ✓✓ (ARKit/ARCore directo)
    RN/Flutter: ✗ (requiere integración nativa anyway)
    Hybrid: ✗
```

---

## 4. Requisiitos de Dispositivos

### 4.1 Plataformas Requeridas

```
Pregunta: ¿En cuáles plataformas debes estar?

[ ] iOS SOLO:
    Nativo Swift: ✓✓
    
[ ] Android SOLO:
    Nativo Kotlin: ✓✓
    
[ ] iOS + Android (ambas):
    Nativo: ✗ (duplicación)
    RN/Flutter: ✓✓
    Hybrid: ✓
    
[ ] iOS + Android + Web:
    RN: ✓ (React Native Web)
    Flutter: ✓ (Flutter Web)
    Hybrid: ✓ (mismo codebase)
    Nativo: ✗
```

### 4.2 Fragmentación (Android específico)
```
Pregunta: ¿Qué rango de API level Android?

[ ] API 30+ SOLO (Android 11+):
    Todas (menos fricción)
    
[ ] API 24+ (Android 7.0+):
    Nativo: ✓
    RN/Flutter: ✓
    
[ ] API 21+ (Android 5.0, muy antiguo):
    Nativo: ✓ (pero work arounds)
    RN/Flutter: ✓ (framework abstrae)
    
[ ] API 19 o inferior (legacy):
    Nativo: ~ (mucho work)
    RN/Flutter: ✗ (no soportado oficialmente)
```

### 4.3 Dispositivos Especiales
```
Pregunta: ¿Necesitas soportar?

[ ] Foldables:
    Nativo: ✓✓
    Flutter: ✓
    RN: ✗ (custom modules requerido)
    Hybrid: ✗
    
[ ] Wearables (smartwatch):
    Nativo: ✓✓
    Flutter: ~ (funciona pero energy cost)
    RN: ✗
    Hybrid: ✗
    
[ ] Tablets / Responsive UI:
    Nativo: ✓
    Flutter: ✓
    RN: ✓
    Hybrid: ~
    
[ ] AR Glasses (futuro):
    Nativo: ✓✓
    RN/Flutter: ✗ (impractical)
    Hybrid: ✗
```

---

## 5. Equipo y Talento

### 5.1 Experiencia Disponible
```
Pregunta: ¿Qué talento tienes?

[ ] Equipo Swift/Objective-C + Kotlin/Java:
    Nativo: ✓✓
    
[ ] Equipo JavaScript/TypeScript:
    RN: ✓✓
    
[ ] Equipo Dart:
    Flutter: ✓✓
    
[ ] Equipo HTML/CSS/JavaScript:
    Hybrid: ✓
    RN: ~ (migrar a React Native require learning)
    
[ ] Equipo mixta (algunos Swift, algunos JS):
    RN/Flutter: ✓ (hybrid teams possible)
    Nativo: ~ (necesita ramp-up)
```

### 5.2 Tamaño de Equipo
```
Pregunta: ¿Cuántos developers tendrás?

[ ] 1-2 personas:
    Nativo: ✗ (imposible dos plataforms)
    RN/Flutter: ✓✓ (one person per platform posible)
    Hybrid: ✓
    
[ ] 3-5 personas:
    Nativo: ~ (one per platform, plus manager)
    RN/Flutter: ✓ (puedo hacer quality)
    
[ ] 5+:
    Nativo: ✓ (equipos dedicados por platform)
    RN/Flutter: ✓ (also viable)
```

### 5.3 Velocidad de Aprendizaje Requerida
```
Pregunta: ¿Qué tan rápido necesitas productividad?

[ ] Inmediata (< 2 semanas):
    Nativo: ✗ (steep learning)
    RN: ✓ (si equipo React)
    Flutter: ✓ (si equipo mobile)
    Hybrid: ✓ (web devs productive immediately)
    
[ ] Moderada (2-8 semanas):
    Nativo: ✓ (if disciplined)
    RN/Flutter: ✓✓
    
[ ] Sin presión (> 8 semanas):
    Nativo: ✓✓ (tiempo para master)
```

---

## 6. Matriz Final: Scoring

### Instrucciones
1. Para cada sección (1-5), suma los ✓ como +2, ~ como +1, ✗ como 0
2. Calcula promedio por tecnología
3. La que más puntúa es candidato

**Ejemplo completado:**

| **Sección** | Nativo | RN | Flutter | Hybrid |
|---|---|---|---|---|
| 1. Negocio | 3 pts | 8 pts | 8 pts | 6 pts |
| 2. Runtime | 9 pts | 6 pts | 8 pts | 2 pts |
| 3. Dominio | 10 pts | 7 pts | 8 pts | 1 pt |
| 4. Dispositivos | 10 pts | 8 pts | 9 pts | 1 pt |
| 5. Equipo | 8 pts | 9 pts | 7 pts | 10 pts |
| **TOTAL** | **40/50** | **38/50** | **40/50** | **20/50** |
| **RECOMENDACIÓN** | Tied with Flutter | | Tied with Nativo | ✗ |

### Reglas de Desempate
Si hay empate después de scoring:

1. **"¿Cuál es el requisito más crítico?"**
   - Si es *rendimiento*, elige Nativo
   - Si es *consistencia visual*, elige Flutter
   - Si es *velocidad de desarrollo*, elige RN

2. **"¿Qué riesgo es peor?"**
   - Si miedo a deuda técnica futura → Nativo
   - Si miedo a time-to-market → RN o Flutter

3. **"¿Qué equipo tienes?"**
   - Usa lo que sabes mejor (menos ramp-up)

---

## Casos de Estudio: Scoring Real

### Airbnb (Viajes, mapas, UI compleja)

| Criterio | Nativo | RN | Flutter | Hybrid |
|---|---|---|---|---|
| Velocidad de mercado (6-12 m) | ~ | ✓ | ✓ | ~ |
| Presupuesto (moderado) | ~ | ✓ | ✓ | ✓ |
| Escala (10M+ users) | ✓ | ~ | ✓ | ✗ |
| Rendimiento UI 60 FPS | ✓ | ✓ | ✓ | ✗ |
| Maps / Gráficos 2D | ✓ | ✓ | ✓ | ✗ |
| Foldables (bonus) | ✓ | ✗ | ✓ | ✗ |
| Equipo (mixta) | ~ | ✓ | ✓ | ~ |
| **Decisión Real** | **Parc nativo** | | **Sería también viable** | |

**Por qué Airbnb eligió parcialmente nativo:** Maps expertise en Google. Performance crítica. Foldables era futuro trend.

### Spotify (Music, streaming, wearables)

| Criterio | Nativo | RN | Flutter | Hybrid |
|---|---|---|---|---|
| Velocidad de mercado | ~ | ✓ | ✓ | ~ |
| Presupuesto (alto, FAANG-like) | ✓ | ✓ | ✓ | ✗ |
| Escala (100M+ users) | ✓ | ~ | ~ | ✗ |
| Audio en tiempo real | ✓ | ✓ | ✓ | ✗ |
| Wearables (Wear OS) | ✓ | ✗ | ~ | ✗ |
| ML/Recomendaciones | ✓ | ✓ | ✓ | ~ |
| Equipo (experto audio) | ✓ | ~ | ~ | ✗ |
| **Decisión Real** | **Nativo + hybrid core** | | | |

**Por qué Spotify eligió nativo core:** Audio expertise, latency-sensitive streaming, wearables, banca de equipos expertos.

---

## Preguntas de Reflexión Final

**Para Airbnb y Spotify, responde:**

1. ¿Si tuvieras que reescribir hoy (2026), elegirías la misma tecnología?
2. ¿Qué cambió en el ecosistema (RN/Flutter moderno) que influiría hoy?
3. ¿Tu app podría funcionar igual (no mejor, no peor) en otra tecnología?
4. ¿Cuál sería el costo de migrar a X?

---

## References

- FAANG architecture decisions (public engineering blogs)
- Stack Overflow Developer Survey (technology adoption trends)
- App Store / Play Store performance metrics (actual user data)
- GitHub commit history (velocity indicator)
