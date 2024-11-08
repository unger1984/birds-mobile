import 'package:birds/domain/entities/online.entity.dart';
import 'package:birds/domain/entities/ws_data_entity.dart';

class WsDataOnlineEntity extends WsDataEntity {
  List<OnlineEntity>? list;

  WsDataOnlineEntity({this.list});
}
