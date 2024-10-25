import 'package:birds/data/models/ws_data_auth_model.dart';
import 'package:birds/data/models/ws_data_count_model.dart';
import 'package:birds/data/models/ws_data_message_model.dart';
import 'package:birds/data/models/ws_data_model.dart';
import 'package:birds/data/models/ws_data_reload_chat_model.dart';
import 'package:birds/data/models/ws_data_sign_in_model.dart';
import 'package:birds/domain/entities/ws_data_auth_entity.dart';
import 'package:birds/domain/entities/ws_data_count_entity.dart';
import 'package:birds/domain/entities/ws_data_message_entity.dart';
import 'package:birds/domain/entities/ws_data_sign_in_entity.dart';
import 'package:birds/domain/entities/ws_entity.dart';

class WsModel {
  WsCmd cmd;
  WsDataModel data;

  WsModel({required this.cmd, required this.data});

  factory WsModel.fromJson(Map<String, dynamic> json) {
    final cmd = WsCmd.fromString(json['cmd']);

    WsDataModel data;
    switch (cmd) {
      case WsCmd.count:
        data = WsDataCountModel.fromJson(json['data']);
        break;
      case WsCmd.auth:
        data = WsDataAuthModel.fromJson(json['data']);
        break;
      case WsCmd.message:
        data = WsDataMessageModel.fromJson(json['data']);
        break;
      case WsCmd.reloadChat:
        data = const WsDataReloadChatModel();
        break;
      case WsCmd.signIn:
        data = WsDataSignInModel.fromJson(json['data']);
        break;
    }

    return WsModel(cmd: cmd, data: data);
  }

  Map<String, dynamic> toJson() => {'cmd': cmd.toString(), 'data': data.toJson()};

  factory WsModel.fromEntity(WsEntity entity) {
    WsDataModel data;
    switch (entity.cmd) {
      case WsCmd.count:
        data = WsDataCountModel.fromEntity((entity.data as WsDataCountEntity));
        break;
      case WsCmd.auth:
        data = WsDataAuthModel.fromEntity((entity.data as WsDataAuthEntity));
        break;
      case WsCmd.message:
        data = WsDataMessageModel.fromEntity((entity.data as WsDataMessageEntity));
        break;
      case WsCmd.reloadChat:
        data = const WsDataReloadChatModel();
        break;
      case WsCmd.signIn:
        data = WsDataSignInModel.fromEntity((entity.data as WsDataSignInEntity));
        break;
    }

    return WsModel(cmd: entity.cmd, data: data);
  }

  WsEntity toEntity() => WsEntity(cmd: cmd, data: data.toEntity());
}
