import 'package:birds/data/models/ws_data_model.dart';
import 'package:birds/domain/entities/ws_data_reload_chat_entity.dart';

class WsDataReloadChatModel extends WsDataModel {
  const WsDataReloadChatModel();

  factory WsDataReloadChatModel.fromJson(Map<String, dynamic> json) => const WsDataReloadChatModel();

  @override
  Map<String, dynamic> toJson() => {};

  factory WsDataReloadChatModel.fromEntity(WsDataReloadChatEntity entity) => const WsDataReloadChatModel();

  @override
  WsDataReloadChatEntity toEntity() => const WsDataReloadChatEntity();
}
