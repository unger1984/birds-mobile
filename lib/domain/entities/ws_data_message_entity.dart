import 'package:birds/domain/entities/user_entity.dart';
import 'package:birds/domain/entities/ws_data_entity.dart';

class WsDataMessageEntity extends WsDataEntity {
  String text;
  DateTime date;
  UserEntity? user;

  WsDataMessageEntity({required this.text, required this.date, this.user});
}
