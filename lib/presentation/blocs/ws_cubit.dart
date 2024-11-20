import 'package:birds/data/models/ws_model.dart';
import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:birds/utils/logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class WsCubitState {
  const WsCubitState();
  const factory WsCubitState.loading() = LoadingWsCubitState;
  const factory WsCubitState.message(WsEntity message) = MessageWsCubitState;
}

final class LoadingWsCubitState extends WsCubitState {
  const LoadingWsCubitState();
}

final class MessageWsCubitState extends WsCubitState {
  final WsEntity message;
  const MessageWsCubitState(this.message);
}

class WsCubit extends Cubit<WsCubitState> {
  static final _log = Logger().create('WsCubit');
  final WsRepository _wsRepository;

  WsCubit({required WsRepository wsRepository})
      : _wsRepository = wsRepository,
        super(const WsCubitState.loading()) {
    _wsRepository.read(_wsListener);
    _wsRepository.reconnect(_reconnect);
    _wsRepository.connect();
  }

  void _wsListener(WsEntity message) {
    _log.debug(WsModel.fromEntity(message).toJson());
    emit(WsCubitState.message(message));
  }

  void _reconnect() {
    emit(const WsCubitState.loading());
  }
}
