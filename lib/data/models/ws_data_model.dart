import 'package:birds/domain/entities/ws_data_entity.dart';

abstract class WsDataModel {
  const WsDataModel();

  Map<String, dynamic> toJson();
  WsDataEntity toEntity();
}
