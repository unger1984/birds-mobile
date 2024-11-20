abstract class ConfigSource {
  Future<void> get initialize;
  String get wsUrl;
  String get hlsUrl1080p;
  String get hlsUrl720p;
  String get hlsUrl480p;
  String get hlsUrl360p;
  String get googleAuthClientId;
  String get donateUrl;
}
