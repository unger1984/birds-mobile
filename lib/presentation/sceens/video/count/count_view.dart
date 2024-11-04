import 'dart:async';

import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/sceens/video/count/count_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

@immutable
class CountView extends StatefulWidget {
  const CountView({super.key});

  @override
  State<CountView> createState() => _CountViewState();
}

class _CountViewState extends State<CountView> {
  final _player = AudioPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    unawaited(_player.dispose());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    unawaited(_init());
  }

  Future<void> _init() async {
    await _player.setAsset('assets/mp3/birds.mp3');
    _player.setLoopMode(LoopMode.all);
    await _player.play();
    if (mounted) {
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _handlePlayPause() {
    _player.playing ? unawaited(_player.pause()) : unawaited(_player.play());
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: BlocBuilder<CountBLoC, CountState>(
            buildWhen: (prev, next) =>
                prev is TotalCountState && next is TotalCountState ? prev.total != next.total : prev != next,
            builder: (context, state) => switch (state) {
              TotalCountState(:int total) => Text(S.of(context).online(total)),
              _ => const SizedBox(height: 20),
            },
          ),
        ),
        IconButton(
          onPressed: _handlePlayPause,
          icon: Icon(_isPlaying ? Icons.queue_music_outlined : Icons.music_off_outlined),
        ),
      ],
    );
  }
}
