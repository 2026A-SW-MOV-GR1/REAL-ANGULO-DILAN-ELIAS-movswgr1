# 🧪 Guía de Pruebas Manuales

Este documento describe paso a paso cómo verificar que todas las funcionalidades están funcionando correctamente.

---

## 🎯 Configuración Inicial

### Antes de Comenzar

1. ✅ Flutter instalado (`flutter --version`)
2. ✅ Emulador corriendo o dispositivo conectado
3. ✅ Proyecto descargado en `tarea_05_persistencia_dual`

### Comandos Preliminares

```bash
cd tarea_05_persistencia_dual
flutter clean
flutter pub get
```

---

## 📝 Pruebas de Funcionalidad

### ✅ PRUEBA 1: Inicialización de la App

**Descripción**: Verificar que la app inicia sin errores

**Pasos**:
```bash
flutter run
```

**Resultado Esperado**:
- ✅ App abre sin errores
- ✅ Muestra pantalla principal
- ✅ AppBar dice "Persistencia Dual"
- ✅ Selector de BD muestra "SQLite" (por defecto)
- ✅ Lista de usuarios está vacía
- ✅ Botón "+" visible en esquina inferior derecha

**Logs Esperados** (en consola):
```
[INFO] Inicializando aplicación...
[INFO] Inicializando Hive...
[INFO] SQLite inicializado correctamente
[INFO] Aplicación lista
```

---

### ✅ PRUEBA 2: Agregar Usuario a SQLite

**Descripción**: Verificar CRUD - Create

**Pasos**:
1. Click en botón "+" (esquina inferior derecha)
2. Ingresa nombre: `Juan Pérez`
3. Ingresa email: `juan@example.com`
4. Click en "Agregar"

**Resultado Esperado**:
- ✅ Diálogo se cierra
- ✅ SnackBar verde dice "Usuario agregado correctamente"
- ✅ Usuario aparece en la lista
- ✅ Muestra inicial "J" en círculo azul

**Logs Esperados**:
```
[INFO] Usuario agregado en SQLITE: Juan Pérez
[DEBUG] Regenerados 1 usuarios de SQLITE
```

---

### ✅ PRUEBA 3: Agregar Más Usuarios a SQLite

**Descripción**: Verificar que se pueden agregar múltiples usuarios

**Pasos**:
1. Click "+" → "María López" / `maria@example.com` → Agregar
2. Click "+" → "Carlos García" / `carlos@example.com` → Agregar
3. Click "+" → "Ana Martínez" / `ana@example.com` → Agregar

**Resultado Esperado**:
- ✅ Todos los usuarios aparecen en la lista
- ✅ 4 usuarios visibles (Juan + 3 nuevos)
- ✅ Cada uno muestra su datos correctamente

**Verificación**:
```
Juan Pérez       [C] [E]
María López      [C] [E]
Carlos García    [C] [E]
Ana Martínez     [C] [E]

C = Editar, E = Eliminar
```

---

### ✅ PRUEBA 4: Cambiar a Hive (NoSQL)

**Descripción**: Verificar cambio dinámico de motor

**Pasos**:
1. En el selector superior, click en botón "NoSQL"

**Resultado Esperado**:
- ✅ Botón "NoSQL" se destaca en naranja
- ✅ La lista está **VACÍA** (Hive sin datos)
- ✅ Mensaje: "No hay usuarios registrados"
- ✅ App NO se reinicia

**Logs Esperados**:
```
[DEBUG] Ya está activa la BD: HIVE
[INFO] Usuarios cargados: 0
```

**Importante**: Los usuarios de SQLite siguen guardados, solo que no se muestran.

---

### ✅ PRUEBA 5: Agregar Usuario a Hive

**Descripción**: Verificar que Hive puede almacenar datos

**Pasos**:
1. Con Hive activo, click "+" 
2. Nombre: `luis@example.com` / Email: `luis@example.com`
3. Click "Agregar"

**Resultado Esperado**:
- ✅ Usuario aparece en la lista (solo en Hive)
- ✅ Muestra "Luis" como nombre

**Logs**:
```
[INFO] Usuario agregado en HIVE
```

---

### ✅ PRUEBA 6: Volver a SQLite - Datos Separados

**Descripción**: Verificar que los datos están realmente separados

**Pasos**:
1. Click en botón "SQL"

**Resultado Esperado**:
- ✅ Botón "SQL" se destaca en azul
- ✅ Lista muestra los 4 usuarios de SQLite (Juan, María, Carlos, Ana)
- ✅ **NO aparece Luis** (que está en Hive)

**Verify**:
```
SQLite (SQL activo):        Hive (NoSQL activo):
- Juan Pérez               - Luis
- María López
- Carlos García
- Ana Martínez
```

**Conclusión**: Datos separados verificados ✅

---

### ✅ PRUEBA 7: Editar Usuario en SQLite

**Descripción**: Verificar CRUD - Update

**Pasos**:
1. Asegurarte que "SQL" está activo
2. Click en icono de lápiz al lado de "Juan Pérez"
3. Cambiar nombre a `Juan Carlos Pérez`
4. Click "Actualizar"

**Resultado Esperado**:
- ✅ Diálogo se cierra
- ✅ SnackBar verde: "Usuario actualizado correctamente"
- ✅ Nombre en la lista cambió a `Juan Carlos Pérez`

**Logs**:
```
[INFO] Usuario actualizado en SQLITE
```

---

### ✅ PRUEBA 8: Eliminar Usuario

**Descripción**: Verificar CRUD - Delete

**Pasos**:
1. Click en icono de basura al lado de "María López"
2. Diálogo de confirmación: Click "Eliminar"

**Resultado Esperado**:
- ✅ Diálogo de confirmación aparece
- ✅ Usuario se elimina
- ✅ SnackBar verde: "Usuario eliminado correctamente"
- ✅ Lista ahora muestra 3 usuarios (no María)

**Logs**:
```
[INFO] Usuario eliminado de SQLITE
```

---

### ✅ PRUEBA 9: Cancelar Eliminación

**Descripción**: Verificar que se puede cancelar

**Pasos**:
1. Click en icono de basura para "Carlos García"
2. En el diálogo, click "Cancelar"

**Resultado Esperado**:
- ✅ Diálogo desaparece
- ✅ Usuario NO se elimina
- ✅ Carlos García sigue en la lista

---

### ✅ PRUEBA 10: Validaciones del Formulario

**Descripción**: Verificar que el formulario valida correctamente

#### Prueba 10A: Nombre vacío
**Pasos**:
1. Click "+"
2. Dejar nombre vacío
3. Ingresa email: `test@example.com`
4. Click "Agregar"

**Resultado Esperado**:
- ✅ Muestra error: "El nombre es requerido"
- ✅ No se agrrega el usuario

#### Prueba 10B: Nombre muy corto
**Pasos**:
1. Click "+"
2. Nombre: `A` (1 carácter)
3. Email: `test@example.com`
4. Click "Agregar"

**Resultado Esperado**:
- ✅ Error: "El nombre debe tener al menos 2 caracteres"

#### Prueba 10C: Email inválido
**Pasos**:
1. Click "+"
2. Nombre: `Test User`
3. Email: `notanemail`
4. Click "Agregar"

**Resultado Esperado**:
- ✅ Error: "Ingrese un email válido"

---

### ✅ PRUEBA 11: Intercambio Frecuente de Motores

**Descripción**: Verificar estabilidad con cambios rápidos

**Pasos**:
1. Click "SQL" → Espera 1 segundo
2. Click "NoSQL" → Espera 1 segundo
3. Click "SQL" → Espera 1 segundo
4. Click "NoSQL"

**Resultado Esperado**:
- ✅ Cambios fluidos y rápidos
- ✅ Sin errores
- ✅ Datos correctos en cada cambio
- ✅ App sigue responsiva

---

### ✅ PRUEBA 12: Estados de Carga

**Descripción**: Verificar que aparece spinner durante operaciones

**Pasos**:
1. Click "+"
2. Ingresa datos
3. Observa rápidamente antes de que aparezca el usuario

**Resultado Esperado**:
- ✅ Breve spinner aparece
- ✅ Usuario se agrega después

---

### ✅ PRUEBA 13: Interfaz Intuitiva

**Descripción**: Verificar que la UI es clara

**Elementos Esperados**:
- ✅ AppBar azul con título "Persistencia Dual"
- ✅ Selector en primer plano (SQL/NoSQL)
- ✅ Lista clara y legible
- ✅ Botón "+" visible y accesible
- ✅ Iconos de edición y eliminación claros
- ✅ SnackBars con mensajes apropiados
- ✅ Diálogos centered y claros

---

## 🧪 Pruebas Unitarias

### Ejecutar Tests

```bash
flutter test
```

**Resultado Esperado**:
```
Test 1: Insertar usuario en SQLiteUserRepository ... ✓
Test 2: Cambiar dinámicamente entre SQLite y Hive ... ✓
Test 3: Verificar que SQLite y Hive mantienen datos separados ... ✓
Test 4: Actualizar usuario en SQLite ... ✓
Test 5: Eliminar usuario en Hive ... ✓

5 tests passed in 2.34s
```

---

## 📊 Pruebas de Performance

### Prueba: Agregar 100 Usuarios

```bash
# Agregar manualmente ~50 usuarios a SQLite
# Luego cambiar a Hive y agregar ~50 usuarios
# Verificar que los cambios siguen siendo suave
```

**Resultado Esperado**:
- ✅ App sigue responsiva
- ✅ Cambios de motor siguen siendo fluidos
- ✅ Listas se cargan rápidamente

---

## 🔍 Verificación de Datos Persistidos

### Prueba: Reiniciar App

**Pasos**:
1. Agregar 3 usuarios a SQLite
2. Cambiar a Hive
3. Agregar 2 usuarios a Hive
4. Cerrar app (click X en emulador o stop en CLI)
5. Ejecutar de nuevo: `flutter run`

**Resultado Esperado**:
- ✅ SQLite recuerda los 3 usuarios
- ✅ Hive recuerda los 2 usuarios
- ✅ Datos persisten después de reinicio

**Logs en consola**:
```
[INFO] SQLite: Se obtuvieron 3 usuarios
[INFO] Hive: Se obtuvieron 2 usuarios
```

---

## 🐛 Verificación de Errores

### Prueba: Logs de Error

Busca en la consola por:
- ❌ `[ERROR]` - Errores críticos
- ✅ No debería haber errores en operaciones normales

### Prueba: SnackBars de Estado

- ✅ Agregar → SnackBar verde "Usuario agregado correctamente"
- ✅ Actualizar → SnackBar verde "Usuario actualizado correctamente"
- ✅ Eliminar → SnackBar verde "Usuario eliminado correctamente"
- ✅ Error → SnackBar rojo con descripción del error

---

## ✅ Checklist Final

Marcar todas como completadas:

- [ ] App inicia sin errores
- [ ] Interfaz es clara y moderna
- [ ] Agregar usuarios en SQLite funciona
- [ ] Agregar usuarios en Hive funciona
- [ ] Cambiar entre motores funciona
- [ ] Datos están separados
- [ ] Editar usuarios funciona
- [ ] Eliminar usuarios funciona
- [ ] Validaciones funcionan
- [ ] SnackBars aparecen correctamente
- [ ] Cambios persisten tras reinicio
- [ ] Tests unitarios pasan
- [ ] No hay errores en consola
- [ ] Acciones están separados: SQLite vs Hive
- [ ] UI es responsiva

---

## 📱 Captura de Pantillas Esperadas

### Pantalla 1: SQLite Vacío
```
┌─────────────────────┐
│  Persistencia Dual  │
├─────────────────────┤
│ SQLite Activo [SQL]│
│              [NoSQL]│
├─────────────────────┤
│  📭 No hay usuarios │
│                     │
│                     │
├─────────────────────┤
│                   [+]│
└─────────────────────┘
```

### Pantalla 2: SQLite con Usuarios
```
┌─────────────────────┐
│  Persistencia Dual  │
├─────────────────────┤
│ SQLite Activo [SQL]│
│              [NoSQL]│
├─────────────────────┤
│ J Juan Pérez        │
│   juan@example.com  │
│   ✏️  🗑              │
│                     │
│ M María López       │
│   maria@example.com │
│   ✏️  🗑              │
│                     │
├─────────────────────┤
│                   [+]│
└─────────────────────┘
```

### Pantalla 3: Hive (Datos Diferentes)
```
┌─────────────────────┐
│  Persistencia Dual  │
├─────────────────────┤
│  Hive Activo  [SQL]│
│              [NoSQL]│
├─────────────────────┤
│ L Luis González     │
│   luis@example.com  │
│   ✏️  🗑              │
│                     │
│                     │
│                     │
│                     │
├─────────────────────┤
│                   [+]│
└─────────────────────┘
```

---

## 🎯 Conclusión

Si todas las pruebas pasan: ✅ **¡LA APLICACIÓN ESTÁ FUNCIONANDO CORRECTAMENTE!**

La aplicación demuestra:
- ✅ CRUD completo
- ✅ Persistencia dual funcionando
- ✅ Cambio dinámico sin reinicio
- ✅ Datos separados
- ✅ UI moderna y responsiva
- ✅ Validaciones correctas
- ✅ Manejo de errores
- ✅ Persistencia de datos

---

**Última actualización**: 29/05/2026
**Aplicación lista para evaluación**: ✅

