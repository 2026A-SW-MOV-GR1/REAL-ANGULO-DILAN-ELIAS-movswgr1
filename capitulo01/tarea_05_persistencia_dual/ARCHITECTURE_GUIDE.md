# 📐 Guía de Arquitectura - Persistencia Dual

## Visión General

Esta aplicación implementa **Architecture Pattern: Repository Pattern** combinado con **Clean Architecture Principles** y gestión de estado con **Provider Pattern**.

## 1. Capas de Arquitectura

```
┌─────────────────────────────────────┐
│     UI LAYER (Presentation)        │
│  ├── screens/                       │
│  ├── widgets/                       │
│  └── providers/                     │
├─────────────────────────────────────┤
│   BUSINESS LOGIC LAYER               │
│  └── repositories/                  │
├─────────────────────────────────────┤
│   DATA LAYER                         │
│  ├── services/                      │
│  └── models/                        │
├─────────────────────────────────────┤
│   UTILITIES & HELPERS               │
│  └── utils/                         │
└─────────────────────────────────────┘
```

## 2. Responsabilidades por Capa

### 📱 UI Layer (Presentation)
**Ubicación:** `lib/screens/`, `lib/widgets/`, `lib/providers/`

**Responsabilidades:**
- Mostrar la interfaz al usuario
- Capturar interacciones del usuario
- Mostrar estados de carga
- Ninguna lógica de negocio

**No hace:**
- ❌ Llamadas directas a BD
- ❌ Lógica de persistencia
- ❌ Transformación de datos

**Componentes:**
- `HomeScreen` - Orquesta la UI
- `UserList` - Muestra usuarios
- `UserFormDialog` - Formulario CRUD
- `DatabaseSwitch` - Selector de motor

### 🎯 Business Logic Layer
**Ubicación:** `lib/repositories/`

**Responsabilidades:**
- Definir reglas de negocio
- Orquestar operaciones de datos
- Proporcionar interfaz uniforme a la UI

**No hace:**
- ❌ Implementación de BD específica
- ❌ Detalles de SQLite/Hive

**Componentes:**
- `UserRepository` (Abstracta) - Interfaz base
- `SQLiteUserRepository` - Implementación SQL
- `HiveUserRepository` - Implementación NoSQL

### 💾 Data Layer
**Ubicación:** `lib/services/`, `lib/models/`

**Responsabilidades:**
- Gestionar persistencia
- Implementar detalles de BD
- Mapear datos

**Componentes:**
- `SQLiteService` - Manejo SQLite
- `HiveService` - Manejo Hive
- `User` (Model) - Estructura de datos

### 🔧 Utils & Helpers
**Ubicación:** `lib/utils/`

**Responsabilidades:**
- Funciones reutilizables
- Logging
- Helpers

## 3. Repository Pattern (Patrón Repositorio)

### Ventajas

```
Sin Repository Pattern:
UI → Direct DB Access → Error prone, tightly coupled

Con Repository Pattern:
UI → Repository (Interface) → Concrete Implementation → DB
```

### Implementación

#### Paso 1: Interfaz Abstracta
```dart
// abstract_user_repository.dart
abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(int id);
}
```

#### Paso 2: Implementación Concreta
```dart
// sqlite_user_repository.dart
class SQLiteUserRepository implements UserRepository {
  @override
  Future<List<User>> getUsers() async {
    // Lógica específica de SQLite
  }
  // ... más métodos
}

// hive_user_repository.dart
class HiveUserRepository implements UserRepository {
  @override
  Future<List<User>> getUsers() async {
    // Lógica específica de Hive
  }
  // ... más métodos
}
```

#### Paso 3: Uso desde Provider
```dart
class DatabaseProvider extends ChangeNotifier {
  late UserRepository _activeRepository;

  Future<void> switchDatabase(DatabaseType db) {
    // Cambiar la implementación
    _activeRepository = db == DatabaseType.sqlite
        ? SQLiteUserRepository()
        : HiveUserRepository();
  }
}
```

## 4. Abstracción & Polimorfismo

### El Poder de la Abstracción

```dart
// La UI NUNCA sabe qué BD está usando
Future<List<User>> loadUsers() {
  return _activeRepository.getUsers();
  // Podría ser SQLite, Hive, O cualquier otra implementación
}
```

### Ventajas

✅ **Desacoplamiento** - UI no depende de implementación específica
✅ **Testabilidad** - Fácil crear mocks
✅ **Extensibilidad** - Agregar nueva BD es trivial
✅ **Mantenibilidad** - Cambios en BD no afectan UI

## 5. Flujo de Datos

### Agregar Usuario

```
HomeScreen (UI)
    ↓ [User hace click en +]
    ↓
UserFormDialog (Captura datos)
    ↓ [Usuario hace click "Agregar"]
    ↓
DatabaseProvider.addUser(name, email)
    ↓ [Llama método del repository activo]
    ↓
SQLiteUserRepository.addUser(user) O HiveUserRepository.addUser(user)
    ↓ [Delega al servicio específico]
    ↓
SQLiteService.insertUser() O HiveService.insertUser()
    ↓ [Escribe en BD]
    ↓
Base de Datos (SQLite / Hive)
    ↓ [Retorna success]
    ↓
Provider notifica cambios
    ↓ [notifyListeners()]
    ↓
UI se reconstruye con nuevos datos
    ↓
UserList muestra usuario nuevo
```

### Cambiar de Motor

```
DatabaseSwitch (UI)
    ↓ [Usuario hace click en "NoSQL"]
    ↓
DatabaseProvider.switchDatabase(DatabaseType.hive)
    ↓ [Cambia _activeRepository]
    ↓
Carga datos del nuevo motor
    ↓
_activeRepository.getUsers() → HiveUserRepository
    ↓
notifyListeners()
    ↓
UI se reconstruye
    ↓
UserList muestra datos de Hive (diferentes a SQLite)
```

## 6. Inyección de Dependencias

### Uso de Provider para DI

```dart
// En main.dart
ChangeNotifierProvider(
  create: (_) => DatabaseProvider(),
  child: const HomeScreen(),
)

// En widgets
final provider = context.read<DatabaseProvider>();
// o para observar cambios:
Consumer<DatabaseProvider>(
  builder: (context, provider, _) {
    return Text(provider.databaseLabel);
  }
)
```

### Ventajas

✅ Fácil de testear
✅ Gestión centralizada
✅ Reactividad automática

## 7. Lógica de Cambio de Motor SIN Reinicio

### ¿Cómo se logra?

1. **El provider mantiene referencia**: `_activeRepository`
2. **Al cambiar**: Simplemente cambia la referencia
3. **Recarga datos**: `await _loadUsers()`
4. **Notifica UI**: `notifyListeners()`
5. **UI se reconstruye**: Mostrando nuevos datos

```dart
Future<void> switchDatabase(DatabaseType database) async {
  // 1. Cambiar referencia
  _activeRepository = database == DatabaseType.sqlite
      ? _sqliteRepository
      : _hiveRepository;

  // 2. Recargar datos del nuevo motor
  await _loadUsers();

  // 3. Notificar UI
  notifyListeners();
}
```

### ¿Por qué no reinicia?

- ❌ No llamamos `runApp()` nuevamente
- ✅ Solo reconstruimos widgets con `notifyListeners()`
- ✅ El estado global persiste
- ✅ Transición suave

## 8. Manejo de Errores

### Estrategia Multi-Capa

```dart
// En Servicio (Capa más baja)
static Future<List<User>> getUsers() async {
  try {
    return await service.getUsers();
  } catch (e) {
    Logger.error('Error en SQLite', e);
    rethrow; // Propagar arriba
  }
}

// En Repository (Capa intermedia)
@override
Future<List<User>> getUsers() async {
  try {
    return await SQLiteService.getAllUsers();
  } catch (e) {
    Logger.error('Error en SQLiteUserRepository', e);
    return []; // O manejar diferente
  }
}

// En Provider (Controla UI)
Future<void> loadUsers() async {
  try {
    _users = await _activeRepository.getUsers();
  } catch (e) {
    Logger.error('Error en Provider', e);
    _users = [];
  }
}

// En UI (Muestra al usuario)
catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: $e'))
  );
}
```

## 9. Datos Separados: ¿Cómo se logra?

### SQLite
- Archivo: `/data/user_data/users_sqlite.db`
- Tabla: `users`
- Datos: Persistidos en disco

### Hive
- Caja: `users_hive`
- Ubicación: `/data/user_data/hive_box.hive`
- Datos: Persistidos en disco

### Independencia

```
SQLiteUserRepository → lee/escribe → users_sqlite.db
                                     [Datos SQLite]
                                     
HiveUserRepository → lee/escribe → users_hive.hive
                                   [Datos Hive]
                                   
Ambas mantienen sus propios datos sin interferir
```

## 10. Testing

### Test de Inserción

```dart
test('Test 1: Insertar usuario en SQLite', () async {
  // Arrange - Preparar
  final repo = SQLiteUserRepository();
  final user = User(id: 1, name: 'Juan', email: 'juan@example.com');

  // Act - Ejecutar
  await repo.addUser(user);
  final users = await repo.getUsers();

  // Assert - Verificar
  expect(users.any((u) => u.name == 'Juan'), isTrue);
});
```

### Test de Cambio de Motor

```dart
test('Test 2: Cambio dinámico entre motores', () async {
  // Arrange
  final sqliteRepo = SQLiteUserRepository();
  final hiveRepo = HiveUserRepository();

  // Act
  final sqliteUsers = await sqliteRepo.getUsers();
  final hiveUsers = await hiveRepo.getUsers();

  // Assert
  expect(sqliteUsers, isA<List<User>>());
  expect(hiveUsers, isA<List<User>>());
});
```

## 11. Logging Estructurado

### Niveles

- `[INFO]` - Eventos importantes
- `[DEBUG]` - Información de desarrollo
- `[WARNING]` - Situaciones inesperadas
- `[ERROR]` - Errores

### Ejemplo

```dart
Logger.info('Usuario agregado en SQLite');
Logger.debug('Recuperados 5 usuarios de Hive');
Logger.warning('Base de datos sin datos');
Logger.error('Error al conectar a BD', exception);
```

## 12. Diagrama de Clases

```
┌─────────────────────────┐
│   UserRepository        │
│  (abstract)             │
├─────────────────────────┤
│ + getUsers()            │
│ + addUser(user)         │
│ + updateUser(user)      │
│ + deleteUser(id)        │
└────────┬────────────────┘
         │
    ┌────┴────┐
    │          │
    ▼          ▼
 ┌───────────────────┐  ┌──────────────────┐
 │ SQLiteUserRep.    │  │ HiveUserRep.     │
 ├───────────────────┤  ├──────────────────┤
 │ - SQLiteService   │  │ - HiveService    │
 │ + getUsers()      │  │ + getUsers()     │
 │ + addUser(user)   │  │ + addUser(user)  │
 └───────────────────┘  └──────────────────┘

┌─────────────────────────────┐
│   DatabaseProvider          │
├─────────────────────────────┤
│ - _activeRepository         │
│ - _currentDatabase          │
│ - _users                    │
├─────────────────────────────┤
│ + switchDatabase()          │
│ + addUser()                 │
│ + updateUser()              │
│ + deleteUser()              │
│ + loadUsers()               │
└─────────────────────────────┘
```

## 13. Ciclo de Vida

### Inicialización
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.initialize();     // Inicializar Hive
  runApp(const MyApp());
}
```

### Creación del Provider
```dart
ChangeNotifierProvider(
  create: (_) => DatabaseProvider(), // Crea provider
  child: const HomeScreen(),
)
```

### En la Pantalla
```dart
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<DatabaseProvider>().loadUsers();
  });
}
```

## 14. Mejores Prácticas Aplicadas

✅ **Separación de Responsabilidades** - Cada clase tiene un propósito
✅ **DRY (Don't Repeat Yourself)** - Reutilización de código
✅ **SOLID Principles**:
   - **S**ingle Responsibility - Cada clase una sola responsabilidad
   - **O**pen/Closed - Abierto a extensión, cerrado a modificación
   - **L**iskov Substitution - Implementaciones intercambiables
   - **I**nterface Segregation - Interfaces específicas
   - **D**ependency Inversion - Depender de abstracciones

✅ **Clean Code** - Nombres descriptivos, métodos pequeños
✅ **Type Safety** - Null safety, tipos específicos
✅ **Error Handling** - Manejo estratificado de errores

## 15. Cómo Agregar una Nueva Base de Datos

Si quisieras agregar MongoDB u otra BD:

1. **Crear Service**
```dart
// services/mongodb_service.dart
class MongoDBService { ... }
```

2. **Crear Repository**
```dart
// repositories/mongodb_user_repository.dart
class MongoDBUserRepository implements UserRepository { ... }
```

3. **Actualizar Provider**
```dart
// providers/database_provider.dart
enum DatabaseType { sqlite, hive, mongodb }
_activeRepository = database == DatabaseType.mongodb
    ? MongoDBUserRepository()
    : ...
```

4. **Actualizar UI**
```dart
// widgets/database_switch.dart
// Agregar botón para MongoDB
```

¡Listo! El resto de la aplicación sigue igual.

---

**Conclusión:** Esta arquitectura proporciona una base sólida, mantenible y escalable para una aplicación de producción.

