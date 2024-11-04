import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/blocs/ws_cubit.dart';
import 'package:birds/presentation/components/bottom_menu/bottom_menu.dart';
import 'package:birds/presentation/sceens/video/chat/chat_bloc.dart';
import 'package:birds/presentation/sceens/video/chat/chat_view.dart';
import 'package:birds/presentation/sceens/video/count/count_bloc.dart';
import 'package:birds/presentation/sceens/video/count/count_view.dart';
import 'package:birds/presentation/sceens/video/video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CountBLoC>(
            create: (context) => CountBLoC(
              wsCubit: BlocProvider.of<WsCubit>(context),
            ),
          ),
          BlocProvider<ChatBLoC>(
            create: (context) => ChatBLoC(
              wsCubit: BlocProvider.of<WsCubit>(context),
            ),
          ),
        ],
        child: OrientationBuilder(
          builder: (context, orientation) => Scaffold(
            appBar: orientation == Orientation.portrait ? AppBar(title: Text(S.of(context).nav_video)) : null,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) => switch (orientation) {
                  Orientation.portrait => const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: VideoPlayer()),
                        CountView(),
                        SizedBox(height: 5),
                        Expanded(child: ChatView()),
                      ],
                    ),
                  Orientation.landscape => const Row(
                      children: [
                        Flexible(flex: 2, child: VideoPlayer()),
                        SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [CountView(), SizedBox(height: 5), Expanded(child: ChatView())],
                          ),
                        ),
                      ],
                    ),
                },
              ),
            ),
            bottomNavigationBar: const BottomMenu(),
          ),
        ),
      ),
    );
  }
}
