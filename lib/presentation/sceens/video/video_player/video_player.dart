import 'dart:async';

import 'package:birds/domain/datasources/config_source.dart';
import 'package:birds/presentation/sceens/video/video_player/video_bloc.dart' hide VideoState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

@immutable
class VideoPlayer extends StatefulWidget {
  final String url;
  const VideoPlayer({super.key, required this.url});

  @override
  State<VideoPlayer> createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  final _player = Player(configuration: const PlayerConfiguration(muted: true));
  late final _controller = VideoController(_player);
  late final _key = GlobalKey<VideoState>();
  final _urlHls1080p = GetIt.I.get<ConfigSource>().hlsUrl1080p;
  final _urlHls720p = GetIt.I.get<ConfigSource>().hlsUrl720p;
  final _urlHls480p = GetIt.I.get<ConfigSource>().hlsUrl480p;
  final _urlHls360p = GetIt.I.get<ConfigSource>().hlsUrl360p;
  Duration? _duration;
  StreamSubscription<bool>? _buffering;
  StreamSubscription<bool>? _playing;
  StreamSubscription<Duration>? _position;
  String _urlType = '360p';

  bool _preloader = true;
  Timer? _timer;

  // не красиво, но нужно
  // ignore: avoid-unnecessary-getter, prefer-widget-private-members
  VideoController get controller => _controller;

  @override
  void initState() {
    super.initState();
    if (widget.url == _urlHls1080p) {
      _urlType = '1080p';
    } else if (widget.url == _urlHls720p) {
      _urlType = '720p';
    } else if (widget.url == _urlHls480p) {
      _urlType = '480p';
    } else if (widget.url == _urlHls360p) {
      _urlType = '360p';
    }
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

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      if (widget.url == _urlHls1080p) {
        _urlType = '1080p';
      } else if (widget.url == _urlHls720p) {
        _urlType = '720p';
      } else if (widget.url == _urlHls480p) {
        _urlType = '480p';
      } else if (widget.url == _urlHls360p) {
        _urlType = '360p';
      }
      unawaited(_init());
    }
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

    await _player.open(Media(widget.url));
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
    await _player.open(Media(widget.url));
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

  void _handleChangeResolution(String? value) {
    context.read<VideoBLoC>().add(VideoEvent.set(value ?? '360p'));
  }

  Widget _videoStateListener(VideoState state) {
    return state.isFullscreen() ? GestureDetector(onDoubleTap: _handleFullScreen) : const SizedBox();
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
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              // borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: DropdownButton<String>(
              underline: const SizedBox(),
              dropdownColor: Colors.black.withOpacity(0.6),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              menuWidth: 110,
              value: _urlType,
              items: ['360p', '480p', '720p', '1080p']
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: _handleChangeResolution,
            ),
          ),
        ),
        if (_preloader || _duration == null || _duration == Duration.zero)
          const Center(child: CircularProgressIndicator(color: Colors.pink)),
      ],
    );
  }
}
