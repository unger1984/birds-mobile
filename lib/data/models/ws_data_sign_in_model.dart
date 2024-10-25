import 'package:birds/data/models/ws_data_model.dart';
import 'package:birds/domain/entities/ws_data_sign_in_entity.dart';

class WsDataSignInModel extends WsDataModel {
  String access_token;

  WsDataSignInModel({required this.access_token});

  factory WsDataSignInModel.fromJson(Map<String, dynamic> json) => WsDataSignInModel(
        access_token: json['access_token'],
      );

  @override
  Map<String, dynamic> toJson() => {'access_token': access_token};

  factory WsDataSignInModel.fromEntity(WsDataSignInEntity entity) =>
      WsDataSignInModel(access_token: entity.access_token);

  @override
  WsDataSignInEntity toEntity() => WsDataSignInEntity(access_token: access_token);
}
