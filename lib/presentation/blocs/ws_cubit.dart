import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class WsCubitState {
  const WsCubitState();
  const factory WsCubitState.loading() = LoadingWsCubitState;
  const factory WsCubitState.message(WsEntity message) = MessageWsCubitState;
}

class LoadingWsCubitState extends WsCubitState {
  const LoadingWsCubitState();
}

class MessageWsCubitState extends WsCubitState {
  final WsEntity message;
  const MessageWsCubitState(this.message);
}

class WsCubit extends Cubit<WsCubitState> {
  final WsRepository _wsRepository;

  WsCubit({required WsRepository wsRepository})
      : _wsRepository = wsRepository,
        super(const LoadingWsCubitState()) {
    _wsRepository.read(_wsListener);
    _wsRepository.connect();
  }

  void _wsListener(WsEntity message) {
    emit(WsCubitState.message(message));
  }
}
