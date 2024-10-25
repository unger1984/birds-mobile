import 'package:birds/domain/entities/user_entity.dart';

class UserModel {
  String name;
  String? avatar;

  UserModel({required this.name, this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {"avatar": avatar, "name": name};

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        name: entity.name,
        avatar: entity.avatar,
      );

  UserEntity toEntity() => UserEntity(name: name, avatar: avatar);
}
