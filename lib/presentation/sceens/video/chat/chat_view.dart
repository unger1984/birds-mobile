import 'package:birds/domain/entities/ws_data_message_entity.dart';
import 'package:birds/presentation/sceens/video/chat/chat_bloc.dart';
import 'package:birds/presentation/sceens/video/chat/chat_form_view.dart';
import 'package:birds/presentation/sceens/video/chat/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBLoC, ChatState>(
      builder: (context, state) => switch (state) {
        SuccessChatState(:List<WsDataMessageEntity> list) => Column(
            children: [
              Expanded(child: ChatList(list: list)),
              const ChatFormView(),
            ],
          ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
