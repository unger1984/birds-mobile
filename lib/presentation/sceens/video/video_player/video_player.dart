import 'dart:async';

import 'package:birds/domain/datasources/config_source.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

@immutable
class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  final _player = Player(configuration: const PlayerConfiguration(muted: true));
  late final _controller = VideoController(_player);
  late final _key = GlobalKey<VideoState>();
  Duration? _duration;
  StreamSubscription<bool>? _buffering;
  StreamSubscription<bool>? _playing;
  StreamSubscription<Duration>? _position;

  final _media = Media(GetIt.I<ConfigSource>().hlsUrl);

  bool _preloader = true;
  Timer? _timer;

  // не красиво, но нужно
  // ignore: avoid-unnecessary-getter, prefer-widget-private-members
  VideoController get controller => _controller;

  @override
  void initState() {
    super.initState();
    unawaited(_init());
  }

  @override
  void dispose() {
    _timer?.cancel();
    unawaited(_buffering?.cancel());
    unawaited(_playing?.cancel());
    unawaited(_position?.cancel());
    unawaited(_player.dispose());
    super.dispose();
  }

  Future<void> _init() async {
    _buffering?.cancel();
    _buffering = _player.stream.buffering.listen((buff) {
      setState(() {
        // _preloader = buff;
        if (buff) {
          // ограничим
          _timer?.cancel();
          _timer = Timer(const Duration(seconds: 10), () => unawaited(reload()));
        } else {
          _timer?.cancel();
        }
      });
    });

    _playing?.cancel();
    _playing = _player.stream.playing.listen((playing) {
      if (!playing) {
        unawaited(_player.play());
      }
    });

    await _player.open(_media);
    _player.setVolume(0);
    if (mounted) {
      setState(() {
        _preloader = false;
      });
    }

    _position?.cancel();
    _position = _player.stream.position.listen((pos) {
      setState(() {
        _duration = pos;
      });
    });
  }

  // Нужно чтобы снаружи дергать перезагрузку
  // ignore: prefer-widget-private-members
  Future<void> reload() async {
    setState(() {
      _preloader = true;
    });
    await _player.stop();
    await _player.remove(0);
    await _player.open(_media);
    await _player.setVolume(0);
    if (!_player.state.playing) await _player.play();
    if (mounted) {
      setState(() {
        _preloader = false;
      });
    }
  }

  void _handleFullScreen() {
    (_key.currentState?.isFullscreen() ?? false)
        ? unawaited(_key.currentState?.exitFullscreen())
        : unawaited(_key.currentState?.enterFullscreen());
  }

  Widget _videoStateListener(VideoState state) {
    return state.isFullscreen() ? GestureDetector(onDoubleTap: _handleFullScreen) : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onDoubleTap: _handleFullScreen,
          child: Video(
            key: _key,
            controller: _controller,
            controls: _videoStateListener,
          ),
        ),
        if (_preloader || _duration == null || _duration == Duration.zero)
          const Center(child: CircularProgressIndicator(color: Colors.pink)),
      ],
    );
  }
}
