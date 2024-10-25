import 'package:birds/data/models/ws_data_model.dart';
import 'package:birds/domain/entities/ws_data_count_entity.dart';

class WsDataCountModel extends WsDataModel {
  int total;

  WsDataCountModel({required this.total});

  factory WsDataCountModel.fromJson(Map<String, dynamic> json) => WsDataCountModel(
        total: json['total'],
      );

  @override
  Map<String, dynamic> toJson() => {'total': total};

  factory WsDataCountModel.fromEntity(WsDataCountEntity entity) => WsDataCountModel(
        total: entity.total,
      );

  @override
  WsDataCountEntity toEntity() => WsDataCountEntity(total: total);
}
