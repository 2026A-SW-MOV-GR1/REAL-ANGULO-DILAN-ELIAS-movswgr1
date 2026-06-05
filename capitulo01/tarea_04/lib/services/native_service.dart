import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('com.example.tarea_04/toast');

  /// Muestra un Toast nativo de Android
  /// [message]: El mensaje a mostrar
  /// [duration]: 'short' (0) o 'long' (1)
  static Future<void> showToast(
    String message, {
    String duration = 'short',
  }) async {
    try {
      await platform.invokeMethod<void>('showToast', {
        'message': message,
        'duration': duration == 'long' ? 1 : 0,
      });
    } on PlatformException {
      // Silenciado: Error al mostrar toast nativo
    }
  }

  /// Muestra un Dialog nativo de Android
  static Future<bool?> showConfirmDialog(
    String title,
    String message,
  ) async {
    try {
      final result = await platform.invokeMethod<bool>('showConfirmDialog', {
        'title': title,
        'message': message,
      });
      return result;
    } on PlatformException {
      // Silenciado: Error al mostrar dialog
      return false;
    }
  }
}


