import 'dart:async';

import 'package:birds/domain/entities/ws_data_message_entity.dart';
import 'package:birds/domain/entities/ws_data_reload_chat_entity.dart';
import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:birds/presentation/blocs/ws_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ChatEvent {
  const ChatEvent();
  const factory ChatEvent.init() = _InitChatEvent;
  const factory ChatEvent.add(WsDataMessageEntity message) = _AddChatEvent;
}

final class _InitChatEvent extends ChatEvent {
  const _InitChatEvent();
}

final class _AddChatEvent extends ChatEvent {
  final WsDataMessageEntity message;
  const _AddChatEvent(this.message);
}

sealed class ChatState {
  const ChatState();
  const factory ChatState.loading() = LoadingChatState;
  const factory ChatState.success(List<WsDataMessageEntity> list) = SuccessChatState;
}

final class LoadingChatState extends ChatState {
  const LoadingChatState();
}

final class SuccessChatState extends ChatState {
  final List<WsDataMessageEntity> list;
  const SuccessChatState(this.list);
}

class ChatBLoC extends Bloc<ChatEvent, ChatState> {
  final WsRepository _wsRepository;
  // В конструкторе
  // ignore: avoid-late-keyword
  late final StreamSubscription<WsCubitState> _streamSubscription;
  List<WsDataMessageEntity> _list = [];

  ChatBLoC({required WsCubit wsCubit, required WsRepository wsRepository})
      : _wsRepository = wsRepository,
        super(const ChatState.loading()) {
    on<ChatEvent>(
      (event, emitter) => switch (event) {
        _InitChatEvent() => _init(emitter),
        _AddChatEvent(:WsDataMessageEntity message) => _add(message, emitter),
      },
    );
    _streamSubscription = wsCubit.stream.listen(_wsListener);
    _wsRepository.send(WsEntity(cmd: WsCmd.reloadChat, data: const WsDataReloadChatEntity()));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();

    return super.close();
  }

  void _wsListener(WsCubitState state) {
    if (state is MessageWsCubitState && state.message.cmd == WsCmd.message) {
      add(ChatEvent.add(state.message.data as WsDataMessageEntity));
    } else if (state is LoadingWsCubitState) {
      add(const ChatEvent.init());
    }
  }

  void _init(Emitter<ChatState> emitter) {
    _list = [];
    emitter(const ChatState.loading());
  }

  void _add(WsDataMessageEntity message, Emitter<ChatState> emitter) {
    _list = [..._list, message];
    emitter(ChatState.success(_list));
  }
}
