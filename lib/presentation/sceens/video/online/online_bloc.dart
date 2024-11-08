import 'dart:async';

import 'package:birds/domain/entities/online.entity.dart';
import 'package:birds/domain/entities/ws_data_online_entity.dart';
import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:birds/presentation/blocs/ws_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class OnlineEvent {
  const OnlineEvent();
  const factory OnlineEvent.set(List<OnlineEntity> list) = _SetOnlineEvent;
}

class _SetOnlineEvent extends OnlineEvent {
  final List<OnlineEntity> list;
  const _SetOnlineEvent(this.list);
}

sealed class OnlineState {
  const OnlineState();
  const factory OnlineState.loading() = LoadingOnlineState;
  const factory OnlineState.success(List<OnlineEntity> list) = SuccessOnlineState;
}

class LoadingOnlineState extends OnlineState {
  const LoadingOnlineState();
}

class SuccessOnlineState extends OnlineState {
  final List<OnlineEntity> list;
  const SuccessOnlineState(this.list);
}

class OnlineBLoC extends Bloc<OnlineEvent, OnlineState> {
  final WsRepository _wsRepository;
  // В конструкторе
  // ignore: avoid-late-keyword
  late final StreamSubscription<WsCubitState> _streamSubscription;
  Timer? _timer;

  OnlineBLoC({required WsCubit wsCubit, required WsRepository wsRepository})
      : _wsRepository = wsRepository,
        super(const OnlineState.loading()) {
    on<OnlineEvent>(
      (event, emitter) => switch (event) {
        _SetOnlineEvent(:List<OnlineEntity> list) => _set(list, emitter),
      },
    );
    _streamSubscription = wsCubit.stream.listen(_wsListener);
    _timer ??= Timer.periodic(const Duration(seconds: 5), _handleUpdate);
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    _timer?.cancel();

    return super.close();
  }

  void _handleUpdate(Timer _) {
    _wsRepository.send(WsEntity(cmd: WsCmd.online, data: WsDataOnlineEntity()));
  }

  void _wsListener(WsCubitState state) {
    if (state is MessageWsCubitState && state.message.cmd == WsCmd.online) {
      add(OnlineEvent.set((state.message.data as WsDataOnlineEntity).list ?? []));
    }
  }

  void _set(List<OnlineEntity> list, Emitter<OnlineState> emitter) {
    emitter(OnlineState.success(list));
  }
}
