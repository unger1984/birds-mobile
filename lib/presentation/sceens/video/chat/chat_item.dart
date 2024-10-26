import 'package:birds/domain/entities/ws_data_message_entity.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

@immutable
class ChatItem extends StatelessWidget {
  final WsDataMessageEntity message;
  const ChatItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final user = message.user;
    final avatar = user?.avatar;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          avatar == null
              ? const SizedBox(width: 24, height: 24)
              : SizedBox(
                  width: 24,
                  height: 24,
                  child: CircleAvatar(backgroundImage: NetworkImage(avatar)),
                ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user != null)
                  Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                Text(message.text),
                Text(timeago.format(message.date), style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
