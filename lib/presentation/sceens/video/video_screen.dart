import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/blocs/ws_cubit.dart';
import 'package:birds/presentation/sceens/video/chat/chat_bloc.dart';
import 'package:birds/presentation/sceens/video/chat/chat_view.dart';
import 'package:birds/presentation/sceens/video/count/count_bloc.dart';
import 'package:birds/presentation/sceens/video/count/count_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).nav_video)),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [CountView(), Expanded(child: ChatView())],
          ),
        ),
      ),
    );
  }
}
