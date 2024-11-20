import 'dart:async';
import 'dart:io';

import 'package:birds/domain/datasources/config_source.dart';
import 'package:birds/domain/datasources/settings_source.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/blocs/ws_cubit.dart';
import 'package:birds/presentation/components/bottom_menu/bottom_menu.dart';
import 'package:birds/presentation/sceens/video/chat/chat_bloc.dart';
import 'package:birds/presentation/sceens/video/chat/chat_view.dart';
import 'package:birds/presentation/sceens/video/count/count_bloc.dart';
import 'package:birds/presentation/sceens/video/count/count_view.dart';
import 'package:birds/presentation/sceens/video/count/sound_bloc.dart';
import 'package:birds/presentation/sceens/video/online/online_view.dart';
import 'package:birds/presentation/sceens/video/video_player/video_bloc.dart';
import 'package:birds/presentation/sceens/video/video_player/video_player.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

@immutable
class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final _videoKey = GlobalKey();
  bool _isOnline = false;

  void _handleOnline() {
    setState(() {
      _isOnline = !_isOnline;
    });
  }

  Future<void> _handleScreenshot() async {
    final bytes = await (_videoKey.currentState as VideoPlayerState).controller.player.screenshot();
    if (bytes == null) {
      Fluttertoast.showToast(
        msg: S.current.screenshot_error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return;
    }

    if (Platform.isAndroid) {
      await Gal.putImageBytes(bytes);
      Fluttertoast.showToast(
        msg: S.current.screenshot_success,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      final fileName = 'screenshot_${DateFormat('yyyyMMdd-HH-mm-ss').format(DateTime.now())}.jpg';
      final result = await getSaveLocation(suggestedName: fileName);
      if (result == null) return;
      const mimeType = 'image/jpeg';
      final textFile = XFile.fromData(bytes, mimeType: mimeType, name: fileName);
      await textFile.saveTo(result.path);
    }
  }

  Future<void> _handleReload() async {
    await (_videoKey.currentState as VideoPlayerState).reload();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CountBLoC>(
            create: (context) => CountBLoC(wsCubit: context.read<WsCubit>()),
          ),
          BlocProvider<ChatBLoC>(
            create: (context) => ChatBLoC(
              wsCubit: context.read<WsCubit>(),
              wsRepository: GetIt.I<WsRepository>(),
            ),
          ),
          BlocProvider<SoundBLoC>(
            create: (context) => SoundBLoC(
              settingsSource: GetIt.I<SettingsSource>(),
            ),
          ),
          BlocProvider<VideoBLoC>(
            create: (context) => VideoBLoC(
              configSource: GetIt.I<ConfigSource>(),
              settingsSource: GetIt.I<SettingsSource>(),
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
                  Orientation.portrait => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: BlocBuilder<VideoBLoC, VideoState>(
                            // Тут так удобнее
                            // ignore: avoid-nested-switch-expressions
                            builder: (context, state) => switch (state) {
                              SuccessVideoState(:String url) => VideoPlayer(key: _videoKey, url: url),
                              _ => const SizedBox(),
                            },
                          ),
                        ),
                        CountView(
                          onOnline: _handleOnline,
                          onScreenshot: _handleScreenshot,
                          onReload: () => unawaited(_handleReload()),
                        ),
                        const SizedBox(height: 5),
                        if (_isOnline) const Expanded(child: OnlineView()),
                        if (_isOnline) const SizedBox(height: 5),
                        const Expanded(child: ChatView()),
                      ],
                    ),
                  Orientation.landscape => Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: BlocBuilder<VideoBLoC, VideoState>(
                            // Тут так удобнее
                            // ignore: avoid-nested-switch-expressions
                            builder: (context, state) => switch (state) {
                              SuccessVideoState(:String url) => VideoPlayer(key: _videoKey, url: url),
                              _ => const SizedBox(),
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CountView(
                                onOnline: _handleOnline,
                                onScreenshot: _handleScreenshot,
                                onReload: () => unawaited(_handleReload()),
                              ),
                              const SizedBox(height: 5),
                              if (_isOnline) const Expanded(child: OnlineView()),
                              if (_isOnline) const SizedBox(height: 5),
                              const Expanded(child: ChatView()),
                            ],
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
