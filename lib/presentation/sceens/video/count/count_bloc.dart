import 'dart:async';

import 'package:birds/domain/entities/ws_data_count_entity.dart';
import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/presentation/blocs/ws_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class CountEvent {
  const CountEvent();
  const factory CountEvent.wait() = _WaitCountEvent;
  const factory CountEvent.set(int total) = _SetCountEvent;
}

class _WaitCountEvent extends CountEvent {
  const _WaitCountEvent();
}

class _SetCountEvent extends CountEvent {
  final int total;
  const _SetCountEvent(this.total);
}

sealed class CountState {
  const CountState();
  const factory CountState.loading() = LoadingCountState;
  const factory CountState.total(int total) = TotalCountState;
}

class LoadingCountState extends CountState {
  const LoadingCountState();
}

class TotalCountState extends CountState {
  final int total;
  const TotalCountState(this.total);
}

class CountBLoC extends Bloc<CountEvent, CountState> {
  // В конструкторе
  // ignore: avoid-late-keyword
  late final StreamSubscription<WsCubitState> _streamSubscription;

  CountBLoC({required WsCubit wsCubit}) : super(const CountState.loading()) {
    on<CountEvent>(
      (event, emitter) => switch (event) {
        _WaitCountEvent() => _wait(emitter),
        _SetCountEvent(:int total) => _set(total, emitter),
      },
    );
    _streamSubscription = wsCubit.stream.listen(_wsListener);
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();

    return super.close();
  }

  void _wsListener(WsCubitState state) {
    if (state is MessageWsCubitState && state.message.cmd == WsCmd.count) {
      add(CountEvent.set((state.message.data as WsDataCountEntity).total));
    }
  }

  void _wait(Emitter<CountState> emitter) {
    emitter(const CountState.loading());
  }

  void _set(int total, Emitter<CountState> emitter) {
    emitter(CountState.total(total));
  }
}
