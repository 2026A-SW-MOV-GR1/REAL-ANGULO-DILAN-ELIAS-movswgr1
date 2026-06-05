# 🚀 Quick Start - Guía Rápida

## ⚡ En 5 Minutos

### 1. Navegar a la Carpeta
```powershell
cd C:\Users\elias\REAL-ANGULO-DILAN-ELIAS-movswgr1\capitulo01\tarea_05_persistencia_dual
```

### 2. Obtener Dependencias
```bash
flutter pub get
```

### 3. Ejecutar la App
```bash
flutter run
```

¡Listo! La aplicación está corriendo.

---

## 🎮 Modo de Uso Básico

### 1️⃣ **Agregar Usuario**
- Tap en botón `+` (abajo-derecha)
- Completar nombre y email
- Tap "Agregar"

### 2️⃣ **Editar Usuario**
- Tap en icono de lápiz
- Modificar datos
- Tap "Actualizar"

### 3️⃣ **Eliminar Usuario**
- Tap en icono de basura
- Confirmar eliminación

### 4️⃣ **Cambiar Motor**
- Top de los botones: "SQL" o "NoSQL"
- Verá usuarios del motor seleccionado
- Datos permanecen separados

---

## 🧪 Ejecutar Tests

```bash
flutter test
```

### Tests Disponibles

| Test | Descripción |
|------|-------------|
| Test 1 | Insertar usuario en SQLite |
| Test 2 | Cambio dinámico entre motores |
| Test 3 | Datos separados SQLite/Hive |
| Test 4 | Actualizar usuario |
| Test 5 | Eliminar usuario |

---

## 🔧 Problemas Comunes

### Error: "pubspec.yaml not found"
```bash
cd tarea_05_persistencia_dual
flutter pub get
```

### Error: "Gradle error" (Android)
```bash
flutter clean
flutter pub get
flutter run
```

### Base de datos corrupta
```bash
flutter clean
flutter pub get
flutter run
```

### App no se reinicia pero BD vacía
- Los datos se guardan por motor
- SQL y NoSQL están separados
- Cambiar de motor para ver datos

---

## 📱 Dispositivos Soportados

- ✅ Android 5.0+
- ✅ iOS 11.0+
- ✅ Emuladores

---

## 📊 Estructura de Carpetas Clave

```
lib/
├── main.dart                 ← Punto de entrada
├── models/user_model.dart    ← Modelo de datos
├── repositories/             ← Lógica de negocio
├── services/                 ← Persistencia
├── providers/                ← Gestión de estado
├── screens/home_screen.dart  ← UI
└── widgets/                  ← Componentes UI
```

---

## 💾 Bases de Datos

| Base | Ubicación | Contenido |
|------|-----------|----------|
| SQLite | `/data/user_data/users_sqlite.db` | Usuarios SQL |
| Hive | `/data/user_data/hive_box.hive` | Usuarios NoSQL |

---

## 🔍 Ver Logs

Habilitar la consola en Android Studio/VS Code:

```
[INFO] Usuario agregado en SQLITE
[DEBUG] Recuperados 3 usuarios de HIVE
[ERROR] Error al insertar usuario
```

---

## 📝 Notas Importantes

- ⚠️ Los datos de SQLite y Hive son **INDEPENDIENTES**
- ⚠️ Al cambiar de motor, la lista cambia automáticamente
- ⚠️ No es necesario reiniciar la app
- ✅ Los cambios se guardan automáticamente
- ✅ No hay conexión a internet necesaria

---

## 🎯 Funcionalidades Implementadas

✅ CRUD completo (Create, Read, Update, Delete)
✅ SQLite + Hive
✅ Cambio dinámico de motor
✅ Persistencia separada
✅ Interfaz moderna (Material 3)
✅ Logs estructurados
✅ Tests unitarios
✅ Arquitectura limpia
✅ Provider pattern
✅ Repository pattern

---

## 📚 Documentación Completa

Para más detalles:
- 📖 `README.md` - Documentación completa
- 🏗️ `ARCHITECTURE_GUIDE.md` - Guía de arquitectura
- 💻 `pubspec.yaml` - Dependencias

---

## 🆘 Soporte Rápido

| Problema | Solución |
|----------|----------|
| App no inicia | `flutter clean && flutter pub get && flutter run` |
| BD vacía | Cambiar diferente motor, los datos están por motor |
| Cambio no se refleja | Esperar 2 segundos, Provider actualiza UI |
| Error de permisos | Ejecutar en emulador con permisos completosGoogle Play (APK) |

---

**Listo para el examen: Persistencia Dual en Aplicaciones Móviles** ✅

