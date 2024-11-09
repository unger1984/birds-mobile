import 'dart:async';

import 'package:birds/domain/entities/online.entity.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

@immutable
class OnlineItem extends StatelessWidget {
  final OnlineEntity online;
  const OnlineItem({super.key, required this.online});

  void _handleTap() {
    unawaited(launchUrlString('https://iplocation.io/ip/${online.ip}'));
  }

  @override
  Widget build(BuildContext context) {
    final user = online.user;
    final avatar = user?.avatar;

    final duration = DateTime.now().difference(online.createdAt);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    final time =
        '${hours > 0 ? '${hours.toString().padLeft(2, '0')}:' : ''}${minutes > 0 ? '${minutes.toString().padLeft(2, '0')}:' : ''}${seconds.toString().padLeft(2, '0')}';

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
          Expanded(child: GestureDetector(onTap: _handleTap, child: Text(online.ip))),
          const SizedBox(width: 8),
          Text(time),
        ],
      ),
    );
  }
}
