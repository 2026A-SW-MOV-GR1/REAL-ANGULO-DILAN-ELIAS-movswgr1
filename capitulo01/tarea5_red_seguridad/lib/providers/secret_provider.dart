import 'package:flutter/material.dart';
import '../models/secret_model.dart';
import '../services/shared_preferences_service.dart';
import '../services/secure_storage_service.dart';
import '../utils/logger.dart';

class SecretProvider extends ChangeNotifier {
  final SharedPreferencesService _prefsService = SharedPreferencesService();
  final SecureStorageService _secureService = SecureStorageService();

  bool _isLoading = false;
  String? _lastRetrievedValue;
  
  bool get isLoading => _isLoading;
  String? get lastRetrievedValue => _lastRetrievedValue;

  Future<void> saveSecret(String key, String value, StorageType type) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (type == StorageType.sharedPreferences) {
        await _prefsService.saveSecret(key, value);
      } else {
        await _secureService.saveSecret(key, value);
      }
      Logger.info('SecretProvider: Secreto guardado en ${type.toString()}');
    } catch (e) {
      Logger.error('SecretProvider: Error al guardar secreto', e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getSecret(String key, StorageType type) async {
    _isLoading = true;
    _lastRetrievedValue = null;
    notifyListeners();

    try {
      String? value;
      if (type == StorageType.sharedPreferences) {
        value = await _prefsService.getSecret(key);
      } else {
        value = await _secureService.getSecret(key);
      }
      
      _lastRetrievedValue = value ?? 'No encontrado';
      Logger.info('SecretProvider: Secreto recuperado de ${type.toString()}');
    } catch (e) {
      _lastRetrievedValue = 'Error al recuperar';
      Logger.error('SecretProvider: Error al recuperar secreto', e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearLastValue() {
    _lastRetrievedValue = null;
    notifyListeners();
  }
}
