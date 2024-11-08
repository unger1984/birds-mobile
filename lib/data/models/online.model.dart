import 'package:birds/data/models/user_model.dart';
import 'package:birds/domain/entities/online.entity.dart';

class OnlineModel {
  String uuid;
  String ip;
  UserModel? user;
  DateTime createdAt;

  OnlineModel({
    required this.uuid,
    required this.ip,
    this.user,
    required this.createdAt,
  });

  factory OnlineModel.fromJson(Map<String, dynamic> json) => OnlineModel(
        uuid: json["uuid"],
        ip: json["ip"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "ip": ip,
        "user": user?.toJson(),
        "uuid": uuid,
      };

  factory OnlineModel.fromEntity(OnlineEntity entity) {
    final user = entity.user;

    return OnlineModel(
      uuid: entity.uuid,
      ip: entity.ip,
      user: user == null ? null : UserModel.fromEntity(user),
      createdAt: entity.createdAt,
    );
  }

  OnlineEntity toEntity() => OnlineEntity(
        uuid: uuid,
        ip: ip,
        user: user?.toEntity(),
        createdAt: createdAt,
      );
}
