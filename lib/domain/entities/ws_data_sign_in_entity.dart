import 'package:birds/domain/entities/ws_data_entity.dart';

class WsDataSignInEntity extends WsDataEntity {
  String access_token;

  WsDataSignInEntity({required this.access_token});
}
