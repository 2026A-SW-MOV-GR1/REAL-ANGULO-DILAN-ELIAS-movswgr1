import '../models/user_model.dart';
import '../utils/logger.dart';
import 'abstract_user_repository.dart';
import '../services/sqlite_service.dart';

/// Implementación del repositorio para SQLite
class SQLiteUserRepository implements UserRepository {
  @override
  Future<List<User>> getUsers() async {
    try {
      final usersData = await SQLiteService.getAllUsers();
      final users = usersData.map((data) => User.fromMap(data)).toList();
      Logger.info('SQLite: Se obtuvieron ${users.length} usuarios');
      return users;
    } catch (e) {
      Logger.error('Error al obtener usuarios de SQLite', e);
      return [];
    }
  }

  @override
  Future<void> addUser(User user) async {
    try {
      await SQLiteService.insertUser(user.toMap());
      Logger.info('SQLite: Usuario agregado - ${user.name}');
    } catch (e) {
      Logger.error('Error al agregar usuario en SQLite', e);
      rethrow;
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      if (user.id == null) {
        throw Exception('El ID del usuario no puede ser nulo');
      }

      await SQLiteService.updateUser(user.id!, user.toMap());
      Logger.info('SQLite: Usuario actualizado - ${user.name}');
    } catch (e) {
      Logger.error('Error al actualizar usuario en SQLite', e);
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      await SQLiteService.deleteUser(id);
      Logger.info('SQLite: Usuario eliminado con ID - $id');
    } catch (e) {
      Logger.error('Error al eliminar usuario en SQLite', e);
      rethrow;
    }
  }

  @override
  Future<void> deleteAllUsers() async {
    try {
      await SQLiteService.deleteAllUsers();
      Logger.info('SQLite: Todos los usuarios elimináados');
    } catch (e) {
      Logger.error('Error al eliminar todos los usuarios en SQLite', e);
      rethrow;
    }
  }
}

