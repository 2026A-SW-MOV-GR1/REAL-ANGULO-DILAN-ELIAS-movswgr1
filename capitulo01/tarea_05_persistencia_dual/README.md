# Persistencia Dual en Flutter

Aplicación Flutter profesional para un examen práctico de "Persistencia Dual en Aplicaciones Móviles". La aplicación permite cambiar dinámicamente entre dos motores de persistencia: **SQLite** y **Hive**.

## 📋 Características

✅ **CRUD Completo** - Crear, Leer, Actualizar y Eliminar usuarios
✅ **Persistencia Dual** - Soporte para SQLite y Hive
✅ **Cambio Dinámico** - Cambiar entre motores sin reiniciar la app
✅ **Datos Separados** - Cada motor mantiene sus propios datos
✅ **Interfaz Reactiva** - UI actualiza automáticamente al cambiar motor
✅ **Indicador Visual** - Muestra qué motor está activo
✅ **Logs Estructurados** - Sistema de logging profesional
✅ **Pruebas Unitarias** - Tests para verificar comportamiento
✅ **Arquitectura Limpia** - Repository Pattern y Separación de Responsabilidades

## 🏗️ Arquitectura

```
lib/
├── main.dart                              # Punto de entrada
├── models/
│   └── user_model.dart                   # Modelo de datos User
├── repositories/
│   ├── abstract_user_repository.dart     # Interfaz base
│   ├── sqlite_user_repository.dart       # Implementación SQLite
│   └── hive_user_repository.dart         # Implementación Hive
├── services/
│   ├── sqlite_service.dart               # Servicio de SQLite
│   └── hive_service.dart                 # Servicio de Hive
├── providers/
│   └── database_provider.dart            # Provider con ChangeNotifier
├── screens/
│   └── home_screen.dart                  # Pantalla principal
├── widgets/
│   ├── database_switch.dart              # Selector de BD
│   ├── user_form.dart                    # Formulario de usuario
│   └── user_list.dart                    # Lista de usuarios
└── utils/
    └── logger.dart                       # Logger estructurado
```

### Flujo de Arquitectura

```
UI (Widgets)
    ↓
Provider (DatabaseProvider)
    ↓
Repository (Abstract Interface)
    ↙          ↘
SQLiteRepository  HiveRepository
    ↓              ↓
SQLiteService   HiveService
    ↓              ↓
SQLite          Hive
```

## 🚀 Instalación y Configuración

### Requisitos Previos

- Flutter 3.0.0 o superior
- Dart 3.0.0 o superior
- Android Studio o VS Code

### Pasos de Instalación

1. **Navegar a la carpeta del proyecto:**
   ```bash
   cd tarea_05_persistencia_dual
   ```

2. **Obtener dependencias:**
   ```bash
   flutter pub get
   ```

3. **Limpiar el caché (recomendado):**
   ```bash
   flutter clean
   flutter pub get
   ```

4. **Ejecutar en emulador o dispositivo:**
   ```bash
   flutter run
   ```

## 📱 Uso de la Aplicación

### Interfaz Principal

La aplicación tiene tres secciones:

1. **Selector de Base de Datos** (arriba)
   - Botón "SQL" para SQLite
   - Botón "NoSQL" para Hive
   - Indicador del motor activo

2. **Lista de Usuarios** (centro)
   - Muestra todos los usuarios del motor activo
   - Click en lápiz para editar
   - Click en basura para eliminar

3. **Botón Flotante** (abajo-derecha)
   - Click para agregar nuevo usuario

### Operaciones

#### Agregar Usuario
1. Click en botón "+"
2. Rellenar nombre y email
3. Click en "Agregar"

#### Editar Usuario
1. Click en icono de lápiz junto al usuario
2. Modificar datos
3. Click en "Actualizar"

#### Eliminar Usuario
1. Click en icono de basura
2. Confirmar eliminación
3. Usuario eliminado

#### Cambiar Motor
1. Click en botón "SQL" o "NoSQL"
2. Verá los datos del motor correspondiente
3. Los datos de cada motor se mantienen separados

## 🗂️ Estructura de Datos - User Model

```dart
class User {
  final int? id;           // Identificador único
  final String name;       // Nombre del usuario
  final String email;      // Email del usuario
}
```

## 📦 Dependencias

| Dependencia | Versión | Propósito |
|------------|---------|----------|
| flutter | Latest | Framework principal |
| provider | ^6.0.0 | Gestión de estado |
| sqflite | ^2.2.8 | Persistencia SQL |
| hive | ^2.2.3 | Persistencia NoSQL |
| hive_flutter | ^1.1.0 | Integración Hive-Flutter |
| path_provider | ^2.0.15 | Acceso a directorio de app |
| path | ^1.8.3 | Manejo de rutas |
| mockito | ^5.4.1 | Testing |

## 🧪 Pruebas Unitarias

### Ejecutar Pruebas

```bash
flutter test
```

### Tests Implementados

1. **Test 1: Insertar usuario en SQLite**
   - Verifica que se puede agregar un usuario a SQLite
   - Confirma que el usuario aparece en la lista

2. **Test 2: Cambio dinámico entre motores**
   - Agrega usuarios en SQLite y Hive
   - Verifica que están en sus respectivas bases de datos

3. **Test 3: Datos separados**
   - Confirma que SQLite y Hive mantienen datos independientes

4. **Test 4: Actualización de usuario**
   - Agrega un usuario
   - Lo actualiza
   - Verifica que el cambio se guardó

5. **Test 5: Eliminación de usuario**
   - Agrega un usuario
   - Lo elimina
   - Verifica que desapareció de la lista

## 📊 Logs Estructurados

La aplicación genera logs en formato estructurado:

```
[INFO] Inicializando aplicación...
[INFO] Inicializando Hive...
[DEBUG] Inicializando SQLite en: /data/databases/users_sqlite.db
[INFO] Usuario agregado en SQLITE
[DEBUG] Cambio de motor a HIVE
[ERROR] Error al insertar usuario
```

### Niveles de Log

- `[INFO]` - Información importante
- `[DEBUG]` - Información de depuración
- `[WARNING]` - Advertencias
- `[ERROR]` - Errores

## 🎯 Características Principales

### 1. Repository Pattern
- Interfaz abstracta `UserRepository`
- Implementaciones concretas para SQLite y Hive
- Fácil de testear y mantener

### 2. Cambio Dinámico de Motor
```dart
// Cambiar a Hive
await provider.switchDatabase(DatabaseType.hive);

// Cambiar a SQLite
await provider.switchDatabase(DatabaseType.sqlite);
```

### 3. Persistencia Separada
- Datos SQLite almacenados en `users_sqlite.db`
- Datos Hive almacenados en `users_hive` box
- Cada motor actúa de forma independiente

### 4. Provider para Estado Global
El `DatabaseProvider` controla:
- Motor de BD activo
- Lista de usuarios actual
- Operaciones CRUD
- Notificación de cambios a la UI

### 5. UI Reactiva
- Todo cambio se refleja automáticamente
- Cargadores de estado
- Mensajes visuales (SnackBar)
- Diálogos de confirmación

## 🔧 Configuración de Bases de Datos

### SQLite Configuration
- Archivo: `services/sqlite_service.dart`
- Tabla: `users`
- Base de datos: `/data/user_data/users_sqlite.db`
- Campos: id (PK), name, email

### Hive Configuration
- Caja: `users_hive`
- Inicializada en: `main()` con `HiveService.initialize()`
- Almacenamiento: `/data/user_data/hive_box.hive`

## 📝 Ejemplo de Uso Programático

```dart
// Obtener el provider
final provider = context.read<DatabaseProvider>();

// Agregar usuario
await provider.addUser('Juan', 'juan@example.com');

// Cambiar a Hive
await provider.switchDatabase(DatabaseType.hive);

// Actualizar usuario (ID 1)
await provider.updateUser(1, 'Juan Carlos', 'juan@example.com');

// Eliminar usuario (ID 1)
await provider.deleteUser(1);

// Cargar usuarios
await provider.loadUsers();
```

## 🐛 Troubleshooting

### Error: "Could not find path_provider"
```bash
flutter pub get flutter pub upgrade
```

### Base de datos corrupta
```bash
flutter clean
flutter pub get
```

### Hive no se inicializa
Asegurate que `HiveService.initialize()` se llama en `main()` antes de `runApp()`

### Los datos no se guardan
- Verifica que tienes permisos de escritura
- Revisa los logs para errores
- Intenta cambiar de motor y volver

## 📊 Estadísticas del Proyecto

- **Archivos Dart**: 13
- **Líneas de código**: ~1,500
- **Tests**: 5
- **Modelos**: 1 (User)
- **Servicios**: 2 (SQLite, Hive)
- **Repositorios**: 2 + 1 interfaz
- **Widgets**: 3
- **Pantallas**: 1

## ✨ Mejoras Futuras

- [ ] Exportar datos a CSV/JSON
- [ ] Búsqueda y filtrado avanzado
- [ ] Paginación
- [ ] Sincronización en la nube
- [ ] Autenticación de usuarios
- [ ] Modo tema oscuro
- [ ] Múltiples idiomas
- [ ] Backup automático

## 📄 Licencia

Proyecto educativo para examen práctico.

## 👨‍💻 Autor

Desarrollado como proyecto de examen: "Persistencia Dual en Aplicaciones Móviles"

## 📧 Soporte

Para problemas o preguntas, revisar los logs o contactar al instructor.

---

**Nota:** Esta es una aplicación profesional con arquitectura limpia. Está lista para ser evaluada en un examen práctico.

