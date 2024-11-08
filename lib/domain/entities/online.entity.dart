import 'package:birds/domain/entities/user_entity.dart';

class OnlineEntity {
  String uuid;
  String ip;
  UserEntity? user;
  DateTime createdAt;

  OnlineEntity({
    required this.uuid,
    required this.ip,
    this.user,
    required this.createdAt,
  });
}
