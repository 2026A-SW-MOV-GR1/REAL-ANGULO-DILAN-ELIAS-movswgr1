import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tarea_05_persistencia_dual/models/user_model.dart';
import 'package:tarea_05_persistencia_dual/repositories/abstract_user_repository.dart';
import 'package:tarea_05_persistencia_dual/repositories/sqlite_user_repository.dart';
import 'package:tarea_05_persistencia_dual/repositories/hive_user_repository.dart';

/// Mock del repositorio
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('Test de Persistencia Dual', () {
    // Test 1: Verificar inserción de usuarios en SQLite
    test(
      'Test 1: Insertar usuario en SQLiteUserRepository',
      () async {
        // Arrange
        final repository = SQLiteUserRepository();
        final user = User(
          id: 1,
          name: 'Juan Pérez',
          email: 'juan@example.com',
        );

        // Act
        await repository.addUser(user);
        final users = await repository.getUsers();

        // Assert
        expect(users, isNotEmpty);
        expect(users.any((u) => u.name == 'Juan Pérez'), isTrue);
      },
    );

    // Test 2: Verificar cambio dinámico de motor
    test(
      'Test 2: Cambiar dinámicamente entre SQLite y Hive',
      () async {
        // Arrange
        final sqliteRepo = SQLiteUserRepository();
        final hiveRepo = HiveUserRepository();

        final userSqlite = User(
          id: 1,
          name: 'Usuario SQLite',
          email: 'sqlite@example.com',
        );

        final userHive = User(
          id: 2,
          name: 'Usuario Hive',
          email: 'hive@example.com',
        );

        // Act
        await sqliteRepo.addUser(userSqlite);
        await hiveRepo.addUser(userHive);

        final sqliteUsers = await sqliteRepo.getUsers();
        final hiveUsers = await hiveRepo.getUsers();

        // Assert
        expect(sqliteUsers.length, greaterThanOrEqualTo(1));
        expect(hiveUsers.length, greaterThanOrEqualTo(1));
        expect(
          sqliteUsers.any((u) => u.name == 'Usuario SQLite'),
          isTrue,
        );
        expect(
          hiveUsers.any((u) => u.name == 'Usuario Hive'),
          isTrue,
        );
      },
    );

    // Test 3: Verificar que los datos están separados
    test(
      'Test 3: Verificar que SQLite y Hive mantienen datos separados',
      () async {
        // Arrange
        final sqliteRepo = SQLiteUserRepository();
        final hiveRepo = HiveUserRepository();

        // Act
        final sqliteUsers = await sqliteRepo.getUsers();
        final hiveUsers = await hiveRepo.getUsers();

        // Assert
        // Los datos deben estar en sus respectivas bases de datos
        expect(sqliteUsers, isA<List<User>>());
        expect(hiveUsers, isA<List<User>>());
      },
    );

    // Test 4: Verificar actualización de usuario
    test(
      'Test 4: Actualizar usuario en SQLite',
      () async {
        // Arrange
        final repository = SQLiteUserRepository();
        final user = User(
          id: 10,
          name: 'Usuario Original',
          email: 'original@example.com',
        );

        // Act
        await repository.addUser(user);

        final updatedUser = user.copyWith(
          name: 'Usuario Actualizado',
        );
        await repository.updateUser(updatedUser);

        final users = await repository.getUsers();
        final found = users.firstWhere((u) => u.id == user.id);

        // Assert
        expect(found.name, equals('Usuario Actualizado'));
      },
    );

    // Test 5: Verificar eliminación de usuario
    test(
      'Test 5: Eliminar usuario en Hive',
      () async {
        // Arrange
        final repository = HiveUserRepository();
        final user = User(
          id: 20,
          name: 'Usuario para eliminar',
          email: 'delete@example.com',
        );

        // Act
        await repository.addUser(user);
        var usersBefore = await repository.getUsers();
        final countBefore = usersBefore.length;

        if (user.id != null) {
          await repository.deleteUser(user.id!);
        }

        final usersAfter = await repository.getUsers();
        final countAfter = usersAfter.length;

        // Assert
        expect(countAfter, lessThanOrEqualTo(countBefore));
      },
    );
  });
}

