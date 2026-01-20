class EnvConfig {
  static const String appTitle = String.fromEnvironment(
    'APP_TITLE',
    defaultValue: 'Valorant Demo',
  );
  static const String apiUrl = String.fromEnvironment('API_URL');
  static const bool debugMode = bool.fromEnvironment(
    'DEBUG_MODE',
    defaultValue: false,
  );
}
