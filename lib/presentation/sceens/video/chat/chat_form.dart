import 'package:birds/domain/entities/user_entity.dart';
import 'package:birds/domain/entities/ws_data_message_entity.dart';
import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

@immutable
class ChatForm extends StatefulWidget {
  final UserEntity user;
  const ChatForm({super.key, required this.user});

  @override
  State<ChatForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  final _controller = TextEditingController();
  final _wscoket = GetIt.I<WsRepository>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit(String? __) => _handleSend();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      _wscoket.send(WsEntity(cmd: WsCmd.message, data: WsDataMessageEntity(text: text, date: DateTime.now())));
      _controller.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatar = widget.user.avatar;

    return Row(
      children: [
        avatar == null
            ? const SizedBox(width: 24, height: 24)
            : SizedBox(
                width: 24,
                height: 24,
                child: CircleAvatar(backgroundImage: NetworkImage(avatar)),
              ),
        const SizedBox(width: 5),
        Expanded(
          child: TextFormField(
            controller: _controller,
            minLines: 1,
            maxLines: 10,
            onFieldSubmitted: _handleSubmit,
          ),
        ),
        IconButton(onPressed: _handleSend, icon: const Icon(Icons.send)),
      ],
    );
  }
}
