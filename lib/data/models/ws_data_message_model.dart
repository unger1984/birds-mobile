import 'package:birds/data/models/user_model.dart';
import 'package:birds/data/models/ws_data_model.dart';
import 'package:birds/domain/entities/ws_data_message_entity.dart';

class WsDataMessageModel extends WsDataModel {
  String text;
  DateTime date;
  UserModel? user;

  WsDataMessageModel({required this.text, required this.date, this.user});

  factory WsDataMessageModel.fromJson(Map<String, dynamic> json) => WsDataMessageModel(
        text: json['text'] as String,
        date: DateTime.parse(json['date'] as String),
        user: json['user'] == null ? null : UserModel.fromJson(json['user']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'text': text,
        'user': user?.toJson(),
      };

  factory WsDataMessageModel.fromEntity(WsDataMessageEntity entity) {
    final user = entity.user;

    return WsDataMessageModel(
      text: entity.text,
      date: entity.date,
      user: user == null ? null : UserModel.fromEntity(user),
    );
  }

  @override
  WsDataMessageEntity toEntity() => WsDataMessageEntity(
        text: text,
        date: date,
        user: user?.toEntity(),
      );
}
