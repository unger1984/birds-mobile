import 'package:birds/domain/entities/ws_data_message_entity.dart';
import 'package:birds/presentation/sceens/video/chat/chat_item.dart';
import 'package:flutter/material.dart';

@immutable
class ChatList extends StatefulWidget {
  final List<WsDataMessageEntity> list;
  const ChatList({super.key, required this.list});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 50), _handleScroll);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChatList oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(const Duration(milliseconds: 50), _handleScroll);
  }

  Future<void> _handleScroll() async {
    if (!_controller.hasClients) return;
    await _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: widget.list.length,
      itemBuilder: (context, index) => ChatItem(message: widget.list.elementAt(index)),
    );
  }
}
