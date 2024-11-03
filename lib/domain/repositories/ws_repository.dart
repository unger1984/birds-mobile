import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/utils/types.dart';
import 'package:flutter/foundation.dart';

abstract class WsRepository {
  void connect();
  void send(WsEntity message);
  void read(ChangeCallback<WsEntity> onMessage);
  void reconnect(VoidCallback onReconnect);
}
