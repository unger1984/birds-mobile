// ignore_for_file: avoid-dynamic, avoid-passing-async-when-sync-expected

import 'dart:async';
import 'dart:convert';

import 'package:birds/data/models/ws_model.dart';
import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WsRepositoryImpl extends WsRepository {
  static final _log = Logger('ConfigSourceDotenv');
  final String url;
  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  // Future<void> Function(WsMessageEntity message)? externalListener;

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
    // Временно
    // ignore: prefer-early-return
    if (kDebugMode) {
      WsEntity msg = WsModel.fromJson(jsonDecode(message)).toEntity();
      print('${msg.cmd} ${msg.data}');
    }
    // if(msg.cmd==WsCmd.message){
    //   print((msg.data as WsDataMessageEntity).text);
    // }
    // switch (msg.cmd) {
    //   case 'start':
    //     msg = msg.copyWith(data: GameUserDataModel.fromJson(msg.data));
    //     break;
    //   default:
    //     msg = msg.copyWith(data: msg.data);
    //     break;
    // }
    // final listener = externalListener;
    // if (listener != null) {
    //   listener(msg);
    // }
  }

  @override
  void connect() {
    unawaited(_reconnect());
  }

  // @override
  // void read(Future<void> Function(WsMessageEntity message) listener) {
  //   externalListener = listener;
  // }
  //
  // @override
  // void send(WsMessageEntity message) {
  //   _channel?.sink.add(jsonEncode(WsMessageModel.fromEntity(message)));
  // }
}
