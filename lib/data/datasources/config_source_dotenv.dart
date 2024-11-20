// ignore_for_file: avoid-late-keyword, avoid-unnecessary-getter

import 'package:birds/domain/datasources/config_source.dart';
import 'package:birds/utils/logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigSourceDotenv extends ConfigSource {
  static final _log = Logger().create('ConfigSourceDotenv');
  late final String _wsUrl;
  late final String _hlsUrl1080p;
  late final String _hlsUrl720p;
  late final String _hlsUrl480p;
  late final String _hlsUrl360p;
  late final String _googleAuthClientId;
  late final String _donateUrl;

  late Future<void> _initialize;

  ConfigSourceDotenv() {
    // Тут так надо.
    // ignore: avoid-async-call-in-sync-function
    _initialize = _init();
  }

  Future<void> _init() async {
    try {
      await dotenv.load();
      _wsUrl = dotenv.maybeGet('URL_WS') ?? '';
      _hlsUrl1080p = dotenv.maybeGet('URL_HLS') ?? '';
      _hlsUrl720p = dotenv.maybeGet('URL_HLS_720P') ?? '';
      _hlsUrl480p = dotenv.maybeGet('URL_HLS_480P') ?? '';
      _hlsUrl360p = dotenv.maybeGet('URL_HLS_360P') ?? '';
      _googleAuthClientId = dotenv.maybeGet('GOOGLE_AUTH_CLIENT_ID') ?? '';
      _donateUrl = dotenv.maybeGet('URL_DONATE') ?? '';
    } catch (error, stack) {
      _log.error('loading .env', error, stack);
    }
  }

  @override
  Future<void> get initialize => _initialize;

  @override
  String get wsUrl => _wsUrl;

  @override
  String get hlsUrl1080p => _hlsUrl1080p;

  @override
  String get hlsUrl720p => _hlsUrl720p;

  @override
  String get hlsUrl480p => _hlsUrl480p;

  @override
  String get hlsUrl360p => _hlsUrl360p;

  @override
  String get googleAuthClientId => _googleAuthClientId;

  @override
  String get donateUrl => _donateUrl;
}
