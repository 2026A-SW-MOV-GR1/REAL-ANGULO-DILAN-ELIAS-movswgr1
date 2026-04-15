# 📚 PARTE 1: Fundamentos Teóricos

**Contenido:** Marco conceptual de arquitectura móvil (1980-2026)

---

## 📖 Documentos en Esta Carpeta

### 1️⃣ [01-Marco-Teorico-Evolucion-Movil.md](../01-Marco-Teorico-Evolucion-Movil.md)
**Propósito:** Historia y arquitectura interna de cada paradigma

**Secciones:**
- Desarrollo Nativo Puro (iOS/Android)
- Era WebView/Híbrido (Cordova, PhoneGap, Ionic)
- Puente Nativo-JavaScript (React Native viejo vs moderno)
- Motor de Renderizado Propio (Flutter)
- Futuro: Foldables, AR/XR, Wearables

**Pregunta respondida:** ¿Qué es un aplicativo nativo? ¿Hay varios? ¿Cómo se clasifican?

---

### 2️⃣ [02-Matriz-Comparativa-Arquitectonica.md](../02-Matriz-Comparativa-Arquitectonica.md)
**Propósito:** Comparación objetiva de todas las opciones

**Principales:**
- Tabla maestra: 20+ criterios (performance, costo, hardware, etc.)
- Frame timing: Desglose de 16.67ms @ 60 FPS por tecnología
- Acceso hardware: GPS, NFC, Bluetooth, LIDAR, AR, biometry
- Casos de uso: Cuándo usar nativo vs RN vs Flutter
- TCO curves: Análisis costo-beneficio en tiempo

---

### 3️⃣ [03-Nuevas-Interfaces-Riesgos-Tecnicos.md](../03-Nuevas-Interfaces-Riesgos-Tecnicos.md)
**Propósito:** Entender limitaciones técnicas de nuevos paradigmas

**Cubre:**
- Foldables: Problemas arquitectónicos, estado reactivo, viabilidad
- AR/XR: Latency budget, sampling rate, occlusion, viabilidad
- Wearables: Energy, CPU, pantalla pequeña
- AR Glasses 2027+: Especulación + conclusión

**Key:** Cross-platform dies en AR/XR

---

### 4️⃣ [04-Glosario-Tecnico-Defensa-Oral.md](../04-Glosario-Tecnico-Defensa-Oral.md)
**Propósito:** Vocabulario técnico preciso

**Contenido:**
- A-Z: 26 términos (AOT, Bridge, Cyber-sickness, Dart, etc.)
- Acronyms: FPS, GPU, IMU, JIT, etc.
- Frases clave: 8 statements para memorizar

**Uso:** Consulta mientras presentas

---

### 5️⃣ [05-Plantilla-Criterios-Decision.md](../05-Plantilla-Criterios-Decision.md)
**Propósito:** Framework para analizar decisiones

**Incluye:**
- Checklist maestra: rubric de 6 categorías
- Scoring: auto-calcular ganador (Nativo vs RN vs Flutter)
- Reglas desempate
- Ejemplos completados (Airbnb + Spotify)

---

## 🎯 Cómo Usar Esta Carpeta

### Quick Read (15 min)
1. Skim "01-Marco-Teorico" (resumen ejecutivo)
2. Skim "02-Matriz-Comparativa" (tablas principales)
3. Read "Preguntas respondidas" en cada

### Detailed Study (1-2 horas)
1. Read documentos 01-05 en orden
2. Toma notas de términos nuevos
3. Abre "04-Glosario" cuando no entiendas un término

### For Presentation (30 min prep)
1. Memoriza 5-10 términos clave de "04-Glosario"
2. Lee "preguntas respondidas" de cada documento
3. Consulta "05-Plantilla" para entender framework

---

## 📊 Temas Cubiertos

| Tema | Documento | Secciones |
|---|---|---|
| **Historia móvil** | 01 | 5 (nativo→hybrid→RN→Flutter→futuro) |
| **Comparación cuantitativa** | 02 | 8 (tablas maestra, frame timing, hardware, TCO) |
| **Nuevas interfaces** | 03 | 5 (foldables, AR, wearables, glasses) |
| **Terminología** | 04 | 26 términos + acronyms |
| **Framework decisión** | 05 | 6 categorías + scoring |
| **TOTAL** | | ~50,000 palabras |

---

## ✅ Use Cases

### "Necesito entender por qué existe Flutter"
→ Lee 01 sección 4 + 02 sección 1

### "Necesito comparar performance nativo vs RN"
→ Lee 02 sección 2 (Frame detailing)

### "Necesito saber si AR es posible en RN"
→ Lee 03 sección 2 (AR/XR)

### "No entiendo qué es 'bridge'"
→ Lee 04 letra "B" (Glosario)

### "Quiero aprender a decidir arquitectura"
→ Lee 05 completo (Plantilla)

---

## 🔗 Referencia Cruzada

Después de leer Parte 1, ve a:
- **Parte 2** para análisis real (Airbnb + Spotify)
- **MASTER-Indice-Consolidado** para resumen general

---

**¡Listo para aprender!**

