enum StorageType { sharedPreferences, secureStorage }

class Secret {
  final String key;
  final String value;
  final StorageType type;

  Secret({
    required this.key,
    required this.value,
    required this.type,
  });
}
