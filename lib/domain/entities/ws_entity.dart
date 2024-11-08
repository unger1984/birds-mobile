import 'package:birds/domain/entities/ws_data_entity.dart';

enum WsCmd {
  auth('auth'),
  count('count'),
  message('message'),
  online('online'),
  reloadChat('reload_chat'),
  signIn('sign_in');

  final String _cmd;

  const WsCmd(this._cmd);

  factory WsCmd.fromString(String cmd) {
    switch (cmd) {
      case 'sign_in':
        return signIn;
      case 'auth':
        return auth;
      case 'count':
        return count;
      case 'reload_chat':
        return reloadChat;
      case 'online':
        return online;
      case 'message':
      default:
        return message;
    }
  }

  @override
  String toString() => _cmd;
}

class WsEntity {
  WsCmd cmd;
  WsDataEntity data;

  WsEntity({required this.cmd, required this.data});
}
