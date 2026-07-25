import 'package:flutter/services.dart';
import '../models/shelter_match_case.dart';

class IntentService {
  static const _methodChannel = MethodChannel('com.examenb2.reencuentro/intent');
  static const _eventChannel = EventChannel('com.examenb2.reencuentro/intent_stream');

  /// Obtiene el caso inicial si la app fue abierta mediante un Intent
  static Future<ShelterMatchCase?> getInitialCase() async {
    try {
      final Map<dynamic, dynamic>? data = await _methodChannel.invokeMethod('getIntentData');
      if (data != null) {
        return ShelterMatchCase.fromMap(data);
      }
    } on PlatformException catch (e) {
      print("Error al obtener Intent inicial: ${e.message}");
    }
    return null;
  }

  /// Escucha nuevos casos en tiempo real mientras la app está abierta
  static Stream<ShelterMatchCase> get onNewCase {
    return _eventChannel.receiveBroadcastStream().map((data) {
      return ShelterMatchCase.fromMap(Map<String, dynamic>.from(data));
    });
  }
}
