import '../models/user_model.dart';
import '../utils/logger.dart';
import 'abstract_user_repository.dart';
import '../services/hive_service.dart';

/// Implementación del repositorio para Hive (NoSQL)
class HiveUserRepository implements UserRepository {
  // Mapa para mantener la relación entre ID y clave de Hive
  // En Hive, la clave es el índice, pero para mantener consistencia con SQLite
  // almacenamos el ID dentro del mapa de datos
  static int _nextId = 1;

  @override
  Future<List<User>> getUsers() async {
    try {
      final usersData = await HiveService.getAllUsers();
      final users = usersData.map((data) => User.fromMap(data)).toList();

      Logger.info('Hive: Se obtuvieron ${users.length} usuarios');
      return users;
    } catch (e) {
      Logger.error('Error al obtener usuarios de Hive', e);
      return [];
    }
  }

  @override
  Future<void> addUser(User user) async {
    try {
      // Asignamos un ID si no existe
      final userToAdd = user.id == null
          ? user.copyWith(id: _generateNextId())
          : user;

      final userData = userToAdd.toMap();
      await HiveService.insertUser(userData);
      Logger.info('Hive: Usuario agregado - ${userToAdd.name}');
    } catch (e) {
      Logger.error('Error al agregar usuario en Hive', e);
      rethrow;
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      if (user.id == null) {
        throw Exception('El ID del usuario no puede ser nulo');
      }

      final usersData = await HiveService.getAllUsers();
      dynamic keyToUpdate;

      // Buscar la clave de Hive que corresponde con este ID único
      for (final data in usersData) {
        if (data['id'] == user.id) {
          keyToUpdate = data['_hiveKey'];
          break;
        }
      }

      if (keyToUpdate != null) {
        await HiveService.updateUser(keyToUpdate, user.toMap());
        Logger.info('Hive: Usuario actualizado - ${user.name}');
      } else {
        throw Exception('Usuario no encontrado en Hive');
      }
    } catch (e) {
      Logger.error('Error al actualizar usuario en Hive', e);
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      final usersData = await HiveService.getAllUsers();
      dynamic keyToDelete;

      // Buscar la clave de Hive que corresponde con este ID único
      for (final data in usersData) {
        if (data['id'] == id) {
          keyToDelete = data['_hiveKey'];
          break;
        }
      }

      if (keyToDelete != null) {
        await HiveService.deleteUser(keyToDelete);
        Logger.info('Hive: Usuario eliminado con ID - $id');
      } else {
        Logger.warning('Usuario con ID $id no encontrado en Hive');
      }
    } catch (e) {
      Logger.error('Error al eliminar usuario en Hive', e);
      rethrow;
    }
  }

  @override
  Future<void> deleteAllUsers() async {
    try {
      await HiveService.deleteAllUsers();
      _nextId = 1;
      Logger.info('Hive: Todos los usuarios eliminados');
    } catch (e) {
      Logger.error('Error al eliminar todos los usuarios en Hive', e);
      rethrow;
    }
  }

  /// Genera el siguiente ID disponible
  static int _generateNextId() {
    return _nextId++;
  }

  /// Resetea el contador de IDs
  static void resetIdCounter() {
    _nextId = 1;
  }
}

