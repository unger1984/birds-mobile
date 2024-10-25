import 'package:birds/data/models/user_model.dart';
import 'package:birds/data/models/ws_data_model.dart';
import 'package:birds/domain/entities/ws_data_auth_entity.dart';

class WsDataAuthModel extends WsDataModel {
  String token;
  UserModel? user;

  WsDataAuthModel({required this.token, this.user});

  factory WsDataAuthModel.fromJson(Map<String, dynamic> json) => WsDataAuthModel(
        token: json["token"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  @override
  Map<String, dynamic> toJson() => {"token": token, "user": user?.toJson()};

  factory WsDataAuthModel.fromEntity(WsDataAuthEntity entity) {
    final user = entity.user;

    return WsDataAuthModel(
      token: entity.token,
      user: user == null ? null : UserModel.fromEntity(user),
    );
  }

  @override
  WsDataAuthEntity toEntity() => WsDataAuthEntity(token: token, user: user?.toEntity());
}
