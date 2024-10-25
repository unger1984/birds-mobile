// ignore_for_file: avoid-late-keyword, avoid-unnecessary-getter

import 'package:birds/domain/datasources/config_source.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';

class ConfigSourceDotenv extends ConfigSource {
  static final _log = Logger('ConfigSourceDotenv');
  late final String _wsUrl;
  late final String _hlsUrl;

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
      _hlsUrl = dotenv.maybeGet('URL_HLS') ?? '';
    } catch (error, stack) {
      _log.severe('loading .env', error, stack);
    }
  }

  @override
  Future<void> get initialize => _initialize;

  @override
  String get wsUrl => _wsUrl;

  @override
  String get hlsUrl => _hlsUrl;
}
