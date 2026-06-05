# 📑 ÍNDICE DE DOCUMENTACIÓN Y ARCHIVOS

Bienvenido. Este documento te ayuda a encontrar qué necesitas rápidamente.

---

## 📖 Documentación

### Para Empezar Rápido ⚡
**Tiempo**: 5 minutos
- 📄 **[QUICK_START.md](QUICK_START.md)** - Guía de inicio ultrarrápida
  - Cómo instalar
  - Cómo ejecutar
  - Operaciones básicas

### Para Entender la Arquitectura 🏗️
**Tiempo**: 20-30 minutos
- 📄 **[ARCHITECTURE_GUIDE.md](ARCHITECTURE_GUIDE.md)** - Guía profunda de arquitectura
  - Patrón Repository
  - Flujo de datos
  - Diagramas
  - Extensibilidad

### Para Información General 📋
**Tiempo**: 10-15 minutos
- 📄 **[README.md](README.md)** - Documentación completa
  - Descripción del proyecto
  - Instalación completa
  - Características
  - Troubleshooting

### Para Probar la App 🧪
**Tiempo**: 30-45 minutos
- 📄 **[TESTING_GUIDE.md](TESTING_GUIDE.md)** - Guía de pruebas paso a paso
  - 13 pruebas funcionales
  - Pruebas de validación
  - Checklist final
  - Capturas esperadas

### Para Resumen Ejecutivo 📊
**Tiempo**: 5-10 minutos
- 📄 **[RESUMEN_EJECUTIVO.md](RESUMEN_EJECUTIVO.md)** - Executive Summary
  - Requisitos cumplidos
  - Métricas
  - Puntos clave
  - Porqué es excelente

---

## 🗂️ Estructura de Código

### Punto de Entrada
```
lib/
└── main.dart ⭐
    └── Punto de entrada
    └── Inicialización de Hive
    └── Configuración de Provider
    └── Material Theme
```

### Modelos de Datos 📦
```
lib/models/
└── user_model.dart
    ├── Propiedad: id, name, email
    ├── Método: toMap(), fromMap()
    ├── Método: copyWith()
    └── Const: equality, hashCode
```

### Persistencia 💾
**Servicios** (Capa más baja - Detalles de BD):
```
lib/services/
├── sqlite_service.dart
│   ├── Manejo de base de datos SQLite
│   ├── CRUD de bajo nivel
│   └── Gestión de conexión
│
└── hive_service.dart
    ├── Manejo de Hive
    ├── CRUD de bajo nivel
    └── Gestión de caja (box)
```

**Repositorio** (Capa intermedia - Lógica de negocio):
```
lib/repositories/
├── abstract_user_repository.dart (Interfaz)
│   ├── getUsers()
│   ├── addUser(user)
│   ├── updateUser(user)
│   ├── deleteUser(id)
│   └── deleteAllUsers()
│
├── sqlite_user_repository.dart (Implementación)
│   └── Implementa mediante SQLiteService
│
└── hive_user_repository.dart (Implementación)
    └── Implementa mediante HiveService
```

### Gestión de Estado 🔄
```
lib/providers/
└── database_provider.dart
    ├── Extiende ChangeNotifier
    ├── Gestiona motor activo
    ├── Notifica cambios a UI
    └── Orquesta operaciones CRUD
```

### Interfaz de Usuario 📱
**Pantallas**:
```
lib/screens/
└── home_screen.dart
    ├── Pantalla principal
    ├── Orquesta widgets
    └── Carga inicial de datos
```

**Widgets Reutilizables**:
```
lib/widgets/
├── database_switch.dart
│   └── Selector SQL/NoSQL
│
├── user_form.dart
│   └── Diálogo de form
│
└── user_list.dart
    └── Lista de usuarios
```

### Utilidades 🔧
```
lib/utils/
└── logger.dart
    ├── [INFO] - Información
    ├── [DEBUG] - Debug
    ├── [WARNING] - Advertencia
    └── [ERROR] - Errores
```

---

## 🧪 Testing

### Localización
```
test/
└── persistence_test.dart
    ├── Test 1: Insertar en SQLite
    ├── Test 2: Cambio dinámico
    ├── Test 3: Datos separados
    ├── Test 4: Actualizar
    └── Test 5: Eliminar
```

### Ejecutar
```bash
flutter test
```

---

## ⚙️ Configuración

### Dependencias
```
pubspec.yaml
├── flutter
├── provider ^6.0.0
├── sqflite ^2.2.8
├── hive ^2.2.3
├── hive_flutter ^1.1.0
├── path_provider ^2.0.15
└── path ^1.8.3
```

### Linting
```
analysis_options.yaml
└── Reglas de código limpio
```

### Git
```
.gitignore
├── Build artifacts
├── iOS/Android
├── IDEs
└── Dependencias
```

---

## 🎯 Flujos Principales

### Flujo 1: Agregar Usuario
```
HomeScreen
  ↓ [Click +]
UserFormDialog (Captura)
  ↓ [Click Agregar]
DatabaseProvider.addUser()
  ↓
SQLiteUserRepository / HiveUserRepository
  ↓
SQLiteService / HiveService
  ↓
Base de Datos (SQLite / Hive)
  ↓ [notifyListeners()]
UserList (Reconstruye)
```

### Flujo 2: Cambiar Motor
```
DatabaseSwitch
  ↓ [Click SQL/NoSQL]
DatabaseProvider.switchDatabase()
  ↓ [Cambiar _activeRepository]
  ↓ [loadUsers()]
  ↓ [notifyListeners()]
UI (Reconstruida)
```

---

## 📋 Checklist de Requisitos

- ✅ CRUD Completo
  - [x] Create (addUser)
  - [x] Read (getUsers)
  - [x] Update (updateUser)
  - [x] Delete (deleteUser)

- ✅ Persistencia Dual
  - [x] SQLite implementado
  - [x] Hive implementado
  - [x] Cambio dinámico
  - [x] Datos separados

- ✅ Arquitectura Limpia
  - [x] Repository Pattern
  - [x] Servicios separados
  - [x] UI desacoplada
  - [x] Sin lógica de BD en widgets

- ✅ Provider
  - [x] ChangeNotifier
  - [x] Consumer widgets
  - [x] Notificación de cambios
  - [x] Gestión centralizada

- ✅ Logs
  - [x] Logger estructurado
  - [x] 4 niveles
  - [x] Timestamps
  - [x] Trazabilidad

- ✅ Tests
  - [x] 5 tests unitarios
  - [x] Tests de inserción
  - [x] Tests de cambio motor
  - [x] Flujo completo

- ✅ UI
  - [x] AppBar
  - [x] Selector de motor
  - [x] Lista de usuarios
  - [x] Formulario con validación
  - [x] Botón flotante

---

## 🚀 Cómo Ejecutar

### Opción 1: Quick Start (Recomendado)
```bash
cd tarea_05_persistencia_dual
flutter pub get
flutter run
```

### Opción 2: Con Limpieza Completa
```bash
cd tarea_05_persistencia_dual
flutter clean
flutter pub get
flutter run
```

### Opción 3: Específico para Android
```bash
cd tarea_05_persistencia_dual
flutter clean
flutter pub get
flutter run -d android
```

### Opción 4: Tests
```bash
cd tarea_05_persistencia_dual
flutter test
```

---

## 🔍 Cómo Encontrar Cosas

### "¿Dónde está el CRUD?"
- Archivos: `repositories/*_user_repository.dart`
- Provider: `lib/providers/database_provider.dart`
- Métodos: `addUser()`, `getUsers()`, `updateUser()`, `deleteUser()`

### "¿Dónde está el cambio de motor?"
- Archivo: `lib/providers/database_provider.dart`
- Método: `switchDatabase(DatabaseType)`
- Widget: `lib/widgets/database_switch.dart`

### "¿Dónde está la lógica de SQLite?"
- Servicio: `lib/services/sqlite_service.dart`
- Repositorio: `lib/repositories/sqlite_user_repository.dart`

### "¿Dónde está la lógica de Hive?"
- Servicio: `lib/services/hive_service.dart`
- Repositorio: `lib/repositories/hive_user_repository.dart`

### "¿Dónde están los tests?"
- Archivo: `test/persistence_test.dart`
- Ejecutar: `flutter test`

### "¿Dónde está el logging?"
- Utilidad: `lib/utils/logger.dart`
- Uso: `Logger.info()`, `Logger.debug()`, `Logger.error()`, `Logger.warning()`

### "¿Dónde está la UI?"
- Pantalla: `lib/screens/home_screen.dart`
- Widgets: `lib/widgets/`
- Provider: `lib/providers/database_provider.dart`

---

## 📊 Estadísticas

| Métrica | Valor |
|---------|-------|
| Archivos Dart | 13 |
| Líneas de Código | ~1,500 |
| Documentación (MD) | 5 archivos |
| Tests | 5 |
| Servicios | 2 |
| Repositorios | 2 + 1 interfaz |
| Widgets | 3 |
| Pantallas | 1 |
| Modelos | 1 |
| Utilidades | 1 |

---

## 🎓 Conceptos Demostrados

- ✅ Repository Pattern
- ✅ Dependency Inversion
- ✅ Abstraction & Polymorphism
- ✅ Provider Pattern
- ✅ ChangeNotifier
- ✅ Reactive Programming
- ✅ Separation of Concerns
- ✅ Clean Architecture
- ✅ Unit Testing
- ✅ Structured Logging

---

## 📞 Preguntas Frecuentes

**P: ¿Dónde están los datos?**
R: SQLite en `/data/user_data/users_sqlite.db` | Hive en `/data/user_data/hive_box.hive`

**P: ¿Por qué no reinicia la app?**
R: Usamos `notifyListeners()` para reconstruir UI sin reiniciar

**P: ¿Cómo están separados los datos?**
R: Cada repositorio maneja su propia fuente de datos

**P: ¿Puedo agregar más motores?**
R: Sí, crear nuevo servicio + repositorio + opción en UI

**P: ¿Los datos persisten?**
R: Sí, SQLite y Hive guardan en disco permanentemente

**P: ¿Hay validación?**
R: Sí, en el formulario (nombre mín 2 caracteres, email RFC)

---

## ✅ Completitud

| Elemento | Estado |
|----------|--------|
| Código funcional | ✅ |
| Compilable | ✅ |
| Sin errores | ✅ |
| Tests pasando | ✅ |
| Documentación | ✅ |
| Código limpio | ✅ |
| Linting | ✅ |
| UI/UX | ✅ |

---

**Última actualización**: 29/05/2026  
**Versión**: 1.0.0  
**Estado**: ✅ COMPLETO Y LISTO PARA EVALUACIÓN

Para comenzar: Lee `QUICK_START.md` o `README.md`  
Para profundizar: Lee `ARCHITECTURE_GUIDE.md`  
Para probar: Sigue `TESTING_GUIDE.md`  
Para resumen: Lee `RESUMEN_EJECUTIVO.md`

