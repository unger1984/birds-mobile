import 'dart:async';

import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/sceens/video/count/count_bloc.dart';
import 'package:birds/presentation/sceens/video/count/sound_bloc.dart';
import 'package:birds/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CountView extends StatefulWidget {
  final VoidCallback onOnline;
  final AsyncVoidCallback onScreenshot;
  final VoidCallback onReload;
  const CountView({super.key, required this.onOnline, required this.onScreenshot, required this.onReload});

  @override
  State<CountView> createState() => _CountViewState();
}

class _CountViewState extends State<CountView> {
  int _count = 0;
  bool _isScreenshot = false;

  void _handlePlayPause() {
    BlocProvider.of<SoundBLoC>(context).add(const SoundEvent.change());
  }

  void _handleTap() {
    if (_count >= 5) {
      setState(() {
        _count = 0;
      });
      widget.onOnline();
    } else {
      setState(() {
        _count++;
      });
    }
  }

  Future<void> _handleScreenshot() async {
    if (mounted) {
      setState(() {
        _isScreenshot = true;
      });
    }
    await widget.onScreenshot();
    if (mounted) {
      setState(() {
        _isScreenshot = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _handleTap,
            child: BlocBuilder<CountBLoC, CountState>(
              buildWhen: (prev, next) =>
                  prev is TotalCountState && next is TotalCountState ? prev.total != next.total : prev != next,
              builder: (context, state) => switch (state) {
                TotalCountState(:int total) => Text(S.of(context).online(total)),
                _ => const SizedBox(height: 20),
              },
            ),
          ),
        ),
        _isScreenshot
            ? const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.screenshot),
              )
            : IconButton(
                onPressed: () => unawaited(_handleScreenshot()),
                icon: Image.asset(semanticLabel: 'screenshot', 'assets/png/camera.png', width: 25, height: 25),
              ),
        IconButton(
          onPressed: _handlePlayPause,
          icon: BlocBuilder<SoundBLoC, SoundState>(
            builder: (context, state) => switch (state) {
              PlaySoundState() => const Icon(Icons.music_off_outlined),
              PauseSoundState() => const Icon(Icons.queue_music_outlined),
              _ => const Icon(Icons.hourglass_empty),
            },
          ),
        ),
        IconButton(onPressed: widget.onReload, icon: const Icon(Icons.refresh)),
      ],
    );
  }
}
