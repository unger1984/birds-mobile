// ignore_for_file: avoid-dynamic, avoid-passing-async-when-sync-expected

import 'dart:async';
import 'dart:convert';

import 'package:birds/data/models/ws_model.dart';
import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:birds/utils/types.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WsRepositoryImpl extends WsRepository {
  static final _log = Logger('ConfigSourceDotenv');
  final String url;
  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  ChangeCallback<WsEntity>? _onMessage;

  WsRepositoryImpl({required this.url});

  Future<void> _reconnect() async {
    if (_channel != null) {
      await Future<void>.delayed(const Duration(seconds: 4));
    }
    _channel = WebSocketChannel.connect(Uri.parse(url), protocols: ['birds']);
    _subscription = _channel?.stream.listen(_listener, cancelOnError: true, onError: _onError, onDone: _onError);
  }

  Future<void> _onError([dynamic err]) async {
    _log.severe('ws error', err);
    if (_subscription != null) {
      await _subscription?.cancel();
      _reconnect();
    }
  }

  void _listener(dynamic message) {
    final listener = _onMessage;
    if (listener != null) {
      WsEntity msg = WsModel.fromJson(jsonDecode(message)).toEntity();
      listener(msg);
    }
  }

  @override
  void connect() {
    unawaited(_reconnect());
  }

  @override
  void read(ChangeCallback<WsEntity> onMessage) {
    _onMessage = onMessage;
  }

  @override
  void send(WsEntity message) {
    _channel?.sink.add(jsonEncode(WsModel.fromEntity(message).toJson()));
  }
}
