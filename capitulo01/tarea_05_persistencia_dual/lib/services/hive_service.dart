import 'package:hive_flutter/hive_flutter.dart';
import '../utils/logger.dart';

/// Servicio de Hive (NoSQL)
/// Maneja la inicialización de Hive y las operaciones básicas
class HiveService {
  static const String _boxName = 'users_hive';
  static Box? _box;

  /// Inicializa Hive
  static Future<void> initialize() async {
    try {
      Logger.info('Inicializando Hive...');
      await Hive.initFlutter();
      Logger.info('Hive inicializado correctamente');
    } catch (e) {
      Logger.error('Error al inicializar Hive', e);
      rethrow;
    }
  }

  /// Obtiene la caja (box) de usuarios
  static Future<Box> get box async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }

    try {
      _box = await Hive.openBox(_boxName);
      Logger.debug('Caja de Hive abierta: $_boxName');
      return _box!;
    } catch (e) {
      Logger.error('Error al abrir caja de Hive', e);
      rethrow;
    }
  }

  /// Obtiene todos los usuarios
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final hiveBox = await box;
      final users = <Map<String, dynamic>>[];

      for (final key in hiveBox.keys) {
        final value = hiveBox.get(key);
        if (value is Map) {
          // Aseguramos que el mapa sea del tipo correcto
          final userData = Map<String, dynamic>.from(value);
          users.add({...userData, '_hiveKey': key});
        }
      }

      Logger.debug('Recuperados ${users.length} usuarios de Hive');
      return users;
    } catch (e) {
      Logger.error('Error al obtener usuarios de Hive', e);
      rethrow;
    }
  }

  /// Inserta un nuevo usuario
  static Future<int> insertUser(Map<String, dynamic> userData) async {
    try {
      final hiveBox = await box;
      // Hive devuelve la clave usada, que es el índice
      final key = await hiveBox.add(userData);
      Logger.info('Usuario insertado en Hive con clave: $key');
      return key;
    } catch (e) {
      Logger.error('Error al insertar usuario en Hive', e);
      rethrow;
    }
  }

  /// Actualiza un usuario existente
  static Future<void> updateUser(
    dynamic key,
    Map<String, dynamic> userData,
  ) async {
    try {
      final hiveBox = await box;
      await hiveBox.put(key, userData);
      Logger.info('Usuario actualizado en Hive con clave: $key');
    } catch (e) {
      Logger.error('Error al actualizar usuario en Hive', e);
      rethrow;
    }
  }

  /// Elimina un usuario
  static Future<void> deleteUser(dynamic key) async {
    try {
      final hiveBox = await box;
      await hiveBox.delete(key);
      Logger.info('Usuario eliminado de Hive con clave: $key');
    } catch (e) {
      Logger.error('Error al eliminar usuario de Hive', e);
      rethrow;
    }
  }

  /// Elimina todos los usuarios
  static Future<void> deleteAllUsers() async {
    try {
      final hiveBox = await box;
      final length = hiveBox.length;
      await hiveBox.clear();
      Logger.info('Todos los usuarios eliminados de Hive (total: $length)');
    } catch (e) {
      Logger.error('Error al eliminar todos los usuarios de Hive', e);
      rethrow;
    }
  }

  /// Cierra la caja de Hive
  static Future<void> closeBox() async {
    if (_box != null && _box!.isOpen) {
      await _box!.close();
      _box = null;
      Logger.info('Caja de Hive cerrada');
    }
  }

  /// Abre nuevamente la caja de Hive (si fue cerrada)
  static Future<void> reopenBox() async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox<Map<String, dynamic>>(_boxName);
      Logger.debug('Caja de Hive reabierta: $_boxName');
    }
  }
}

