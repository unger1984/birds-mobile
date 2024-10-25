import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class WsCubitState {
  const WsCubitState();
  const factory WsCubitState.loading() = LoadingWsCubitState;
}

class LoadingWsCubitState extends WsCubitState {
  const LoadingWsCubitState();
}

class WsCubit extends Cubit<WsCubitState> {
  final WsRepository _wsRepository;

  WsCubit({required WsRepository wsRepository})
      : _wsRepository = wsRepository,
        super(const LoadingWsCubitState()) {
    _wsRepository.connect();
  }
}
