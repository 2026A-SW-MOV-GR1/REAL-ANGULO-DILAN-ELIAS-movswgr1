import '../models/user_model.dart';

/// Interfaz abstracta para el repositorio de usuarios
/// Define el contrato que deben cumplir todas las implementaciones de persistencia
abstract class UserRepository {
  /// Obtiene la lista de todos los usuarios
  Future<List<User>> getUsers();

  /// Agrega un nuevo usuario
  Future<void> addUser(User user);

  /// Actualiza un usuario existente
  Future<void> updateUser(User user);

  /// Elimina un usuario por ID
  Future<void> deleteUser(int id);

  /// Elimina todos los usuarios (para limpiar base de datos)
  Future<void> deleteAllUsers();
}

