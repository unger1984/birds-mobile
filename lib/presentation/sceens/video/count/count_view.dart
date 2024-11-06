import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/sceens/video/count/count_bloc.dart';
import 'package:birds/presentation/sceens/video/count/sound_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CountView extends StatefulWidget {
  const CountView({super.key});

  @override
  State<CountView> createState() => _CountViewState();
}

class _CountViewState extends State<CountView> {
  void _handlePlayPause() {
    BlocProvider.of<SoundBLoC>(context).add(const SoundEvent.change());
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
          icon: BlocBuilder<SoundBLoC, SoundState>(
            builder: (context, state) => switch (state) {
              PlaySoundState() => const Icon(Icons.music_off_outlined),
              PauseSoundState() => const Icon(Icons.queue_music_outlined),
              _ => const Icon(Icons.hourglass_empty),
            },
          ),
        ),
      ],
    );
  }
}
