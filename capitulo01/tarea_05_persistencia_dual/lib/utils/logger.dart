/// Logger estructurado para la aplicación
class Logger {
  static const String _info = '[INFO]';
  static const String _debug = '[DEBUG]';
  static const String _error = '[ERROR]';
  static const String _warning = '[WARNING]';

  /// Log de información
  static void info(String message) {
    final timestamp = _getTimestamp();
    print('$timestamp $_info $message');
  }

  /// Log de depuración
  static void debug(String message) {
    final timestamp = _getTimestamp();
    print('$timestamp $_debug $message');
  }

  /// Log de error
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    final timestamp = _getTimestamp();
    print('$timestamp $_error $message');
    if (error != null) {
      print('$timestamp $_error Error: $error');
    }
    if (stackTrace != null) {
      print('$timestamp $_error StackTrace: $stackTrace');
    }
  }

  /// Log de advertencia
  static void warning(String message) {
    final timestamp = _getTimestamp();
    print('$timestamp $_warning $message');
  }

  /// Obtiene timestamp en formato HH:MM:SS
  static String _getTimestamp() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }
}

