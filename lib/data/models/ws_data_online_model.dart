// ignore_for_file: avoid-dynamic

import 'package:birds/data/models/online.model.dart';
import 'package:birds/data/models/ws_data_model.dart';
import 'package:birds/domain/entities/ws_data_online_entity.dart';

class WsDataOnlineModel extends WsDataModel {
  List<OnlineModel>? list;

  WsDataOnlineModel({this.list});

  factory WsDataOnlineModel.fromJson(Map<String, dynamic> json) => WsDataOnlineModel(
        list: json.containsKey('list') && json["list"] != null
            ? (json['list'] as List<dynamic>?)?.map((item) => OnlineModel.fromJson(item)).toList()
            : null,
      );

  @override
  Map<String, dynamic> toJson() => {"list": list?.map((item) => item.toJson())};

  factory WsDataOnlineModel.fromEntity(WsDataOnlineEntity entity) => WsDataOnlineModel(
        list: entity.list?.map((item) => OnlineModel.fromEntity(item)).toList(),
      );

  @override
  WsDataOnlineEntity toEntity() => WsDataOnlineEntity(list: list?.map((item) => item.toEntity()).toList());
}
