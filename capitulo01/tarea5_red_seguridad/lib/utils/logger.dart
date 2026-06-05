class Logger {
  static const String _info = '[INFO]';
  static const String _debug = '[DEBUG]';
  static const String _error = '[ERROR]';

  static void info(String message) {
    print('${DateTime.now()} $_info $message');
  }

  static void debug(String message) {
    print('${DateTime.now()} $_debug $message');
  }

  static void error(String message, [dynamic error]) {
    print('${DateTime.now()} $_error $message ${error ?? ""}');
  }
}
