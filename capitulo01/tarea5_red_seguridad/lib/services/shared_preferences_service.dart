import 'package:shared_preferences/shared_preferences.dart';
import '../utils/logger.dart';

class SharedPreferencesService {
  Future<void> saveSecret(String key, String value) async {
    try {
      Logger.info('SharedPreferences: Guardando secreto con clave: $key');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
      Logger.debug('SharedPreferences: Secreto guardado correctamente');
    } catch (e) {
      Logger.error('SharedPreferences: Error al guardar secreto', e);
      rethrow;
    }
  }

  Future<String?> getSecret(String key) async {
    try {
      Logger.info('SharedPreferences: Recuperando secreto con clave: $key');
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(key);
      if (value != null) {
        Logger.debug('SharedPreferences: Secreto encontrado');
      } else {
        Logger.debug('SharedPreferences: Secreto no encontrado');
      }
      return value;
    } catch (e) {
      Logger.error('SharedPreferences: Error al recuperar secreto', e);
      rethrow;
    }
  }
}
