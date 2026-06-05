import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/logger.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveSecret(String key, String value) async {
    try {
      Logger.info('SecureStorage: Guardando secreto con clave: $key');
      await _storage.write(key: key, value: value);
      Logger.debug('SecureStorage: Secreto guardado correctamente');
    } catch (e) {
      Logger.error('SecureStorage: Error al guardar secreto', e);
      rethrow;
    }
  }

  Future<String?> getSecret(String key) async {
    try {
      Logger.info('SecureStorage: Recuperando secreto con clave: $key');
      final value = await _storage.read(key: key);
      if (value != null) {
        Logger.debug('SecureStorage: Secreto encontrado');
      } else {
        Logger.debug('SecureStorage: Secreto no encontrado');
      }
      return value;
    } catch (e) {
      Logger.error('SecureStorage: Error al recuperar secreto', e);
      rethrow;
    }
  }
}
