import 'package:flutter/services.dart';
import '../models/shelter_match_case.dart';

class IntentService {
  static const _methodChannel = MethodChannel('com.examenb2.reencuentro/intent');
  static const _eventChannel = EventChannel('com.examenb2.reencuentro/intent_stream');

  static Future<ShelterMatchCase?> getInitialCase() async {
    try {
      final Map<dynamic, dynamic>? data = await _methodChannel.invokeMethod('getIntentData');
      if (data != null) return ShelterMatchCase.fromMap(data);
    } catch (e) {
      print("Error Intent Inicial: $e");
    }
    return null;
  }

  static Stream<ShelterMatchCase> get onNewCase {
    return _eventChannel.receiveBroadcastStream().map((data) {
      return ShelterMatchCase.fromMap(Map<String, dynamic>.from(data));
    });
  }
}
