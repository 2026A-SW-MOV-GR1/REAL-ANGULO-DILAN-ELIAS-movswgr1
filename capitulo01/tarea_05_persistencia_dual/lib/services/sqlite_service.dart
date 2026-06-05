import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../utils/logger.dart';

/// Servicio de SQLite
/// Maneja la inicialización de la base de datos y las operaciones básicas
class SQLiteService {
  static Database? _database;

  static const String _dbName = 'users_sqlite.db';
  static const String _tableName = 'users';
  static const int _dbVersion = 1;

  /// Obtiene la instancia de la base de datos (singleton)
  static Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database!;
  }

  /// Inicializa la base de datos
  static Future<Database> _initializeDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, _dbName);

      Logger.info('Inicializando SQLite en: $path');

      final database = await openDatabase(
        path,
        version: _dbVersion,
        onCreate: _onCreate,
      );

      Logger.info('SQLite inicializado correctamente');
      return database;
    } catch (e) {
      Logger.error('Error al inicializar SQLite', e);
      rethrow;
    }
  }

  /// Crea la tabla de usuarios
  static Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE $_tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL
        )
      ''');
      Logger.info('Tabla $_tableName creada correctamente en SQLite');
    } catch (e) {
      Logger.error('Error al crear tabla en SQLite', e);
      rethrow;
    }
  }

  /// Obtiene todos los usuarios
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final db = await database;
      final result = await db.query(_tableName);
      Logger.debug('Recuperados ${result.length} usuarios de SQLite');
      return result;
    } catch (e) {
      Logger.error('Error al obtener usuarios de SQLite', e);
      rethrow;
    }
  }

  /// Inserta un nuevo usuario
  static Future<int> insertUser(Map<String, dynamic> userData) async {
    try {
      final db = await database;
      final id = await db.insert(_tableName, userData);
      Logger.info('Usuario insertado en SQLite con ID: $id');
      return id;
    } catch (e) {
      Logger.error('Error al insertar usuario en SQLite', e);
      rethrow;
    }
  }

  /// Actualiza un usuario existente
  static Future<int> updateUser(
    int id,
    Map<String, dynamic> userData,
  ) async {
    try {
      final db = await database;
      final result = await db.update(
        _tableName,
        userData,
        where: 'id = ?',
        whereArgs: [id],
      );
      Logger.info('Usuario actualizado en SQLite con ID: $id');
      return result;
    } catch (e) {
      Logger.error('Error al actualizar usuario en SQLite', e);
      rethrow;
    }
  }

  /// Elimina un usuario
  static Future<int> deleteUser(int id) async {
    try {
      final db = await database;
      final result = await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      Logger.info('Usuario eliminado de SQLite con ID: $id');
      return result;
    } catch (e) {
      Logger.error('Error al eliminar usuario de SQLite', e);
      rethrow;
    }
  }

  /// Elimina todos los usuarios
  static Future<int> deleteAllUsers() async {
    try {
      final db = await database;
      final result = await db.delete(_tableName);
      Logger.info('Todos los usuarios eliminados de SQLite (total: $result)');
      return result;
    } catch (e) {
      Logger.error('Error al eliminar todos los usuarios de SQLite', e);
      rethrow;
    }
  }

  /// Cierra la conexión a la base de datos
  static Future<void> closeDatabase() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
      Logger.info('Conexión a SQLite cerrada');
    }
  }

  /// Abre nuevamente la conexión a la base de datos (si fue cerrada)
  static Future<void> reopenDatabase() async {
    if (_database == null || !_database!.isOpen) {
      _database = await _initializeDatabase();
    }
  }
}

