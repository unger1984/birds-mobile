import 'package:birds/domain/entities/online.entity.dart';
import 'package:birds/presentation/sceens/video/online/online_item.dart';
import 'package:flutter/material.dart';

@immutable
class OnlineList extends StatelessWidget {
  final List<OnlineEntity> list;
  const OnlineList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => OnlineItem(online: list.elementAt(index)),
    );
  }
}
