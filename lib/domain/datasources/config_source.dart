abstract class ConfigSource {
  Future<void> get initialize;
  String get wsUrl;
  String get hlsUrl;
  String get googleAuthClientId;
  String get donateUrl;
}
