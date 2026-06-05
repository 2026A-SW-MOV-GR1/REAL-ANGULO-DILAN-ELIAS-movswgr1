import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../repositories/abstract_user_repository.dart';
import '../repositories/sqlite_user_repository.dart';
import '../repositories/hive_user_repository.dart';
import '../utils/logger.dart';

/// Enum para los tipos de base de datos disponibles
enum DatabaseType { sqlite, hive }

/// Provider que gestiona la persistencia dual
/// Controla qué motor está activo y notifica cambios a la UI
class DatabaseProvider extends ChangeNotifier {
  // Repositorios
  late SQLiteUserRepository _sqliteRepository;
  late HiveUserRepository _hiveRepository;

  // Repositorio activo
  late UserRepository _activeRepository;

  // Variables de estado
  DatabaseType _currentDatabase = DatabaseType.sqlite;
  List<User> _users = [];
  bool _isLoading = false;

  // Getters
  DatabaseType get currentDatabase => _currentDatabase;
  List<User> get users => _users;
  bool get isLoading => _isLoading;

  String get databaseLabel {
    switch (_currentDatabase) {
      case DatabaseType.sqlite:
        return 'SQLite';
      case DatabaseType.hive:
        return 'Hive';
    }
  }

  /// Constructor - Inicializa los repositorios
  DatabaseProvider() {
    _sqliteRepository = SQLiteUserRepository();
    _hiveRepository = HiveUserRepository();
    _activeRepository = _sqliteRepository;

    Logger.info('DatabaseProvider inicializado - BD activa: SQLite');
  }

  /// Cambia dinámicamente entre SQLite y Hive
  Future<void> switchDatabase(DatabaseType database) async {
    if (_currentDatabase == database) {
      Logger.debug('Ya está activa la BD: ${database.toString()}');
      return;
    }

    try {
      _setLoading(true);

      Logger.info('Cambiando de BD a: ${database.toString()}');

      _currentDatabase = database;
      _activeRepository = database == DatabaseType.sqlite
          ? _sqliteRepository
          : _hiveRepository;

      // Cargar datos del nuevo motor
      await _loadUsers();

      Logger.info('BD cambiada correctamente a: ${database.toString()}');
      notifyListeners();
    } catch (e) {
      Logger.error('Error al cambiar de BD', e);
      _setLoading(false);
      rethrow;
    }
  }

  /// Carga todos los usuarios del repositorio activo
  Future<void> _loadUsers() async {
    try {
      _setLoading(true);
      _users = await _activeRepository.getUsers();
      Logger.debug('Usuarios cargados: ${_users.length}');
      notifyListeners();
    } catch (e) {
      Logger.error('Error al cargar usuarios', e);
      _users = [];
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Carga los usuarios (wrapper público)
  Future<void> loadUsers() async {
    return _loadUsers();
  }

  /// Agrega un nuevo usuario
  Future<void> addUser(String name, String email) async {
    try {
      _setLoading(true);

      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.hashCode.abs(),
        name: name,
        email: email,
      );

      await _activeRepository.addUser(newUser);

      Logger.info(
        'Usuario agregado en ${_currentDatabase.toString().split('.').last.toUpperCase()}: $name',
      );

      // Recargamos la lista
      await _loadUsers();
    } catch (e) {
      Logger.error('Error al agregar usuario', e);
      _setLoading(false);
      rethrow;
    }
  }

  /// Actualiza un usuario existente
  Future<void> updateUser(int id, String name, String email) async {
    try {
      _setLoading(true);

      final updatedUser = User(
        id: id,
        name: name,
        email: email,
      );

      await _activeRepository.updateUser(updatedUser);

      Logger.info(
        'Usuario actualizado en ${_currentDatabase.toString().split('.').last.toUpperCase()}: $name',
      );

      // Recargamos la lista
      await _loadUsers();
    } catch (e) {
      Logger.error('Error al actualizar usuario', e);
      _setLoading(false);
      rethrow;
    }
  }

  /// Elimina un usuario
  Future<void> deleteUser(int id) async {
    try {
      _setLoading(true);

      await _activeRepository.deleteUser(id);

      Logger.info(
        'Usuario eliminado en ${_currentDatabase.toString().split('.').last.toUpperCase()}',
      );

      // Recargamos la lista
      await _loadUsers();
    } catch (e) {
      Logger.error('Error al eliminar usuario', e);
      _setLoading(false);
      rethrow;
    }
  }

  /// Establece el estado de carga
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

