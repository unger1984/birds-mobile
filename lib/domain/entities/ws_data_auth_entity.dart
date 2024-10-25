import 'package:birds/domain/entities/user_entity.dart';
import 'package:birds/domain/entities/ws_data_entity.dart';

class WsDataAuthEntity extends WsDataEntity {
  String token;
  UserEntity? user;

  WsDataAuthEntity({required this.token, this.user});
}
