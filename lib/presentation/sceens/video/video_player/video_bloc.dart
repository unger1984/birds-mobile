import 'dart:async';

import 'package:birds/domain/datasources/config_source.dart';
import 'package:birds/domain/datasources/settings_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class VideoEvent {
  const VideoEvent();
  const factory VideoEvent.init() = _InitVideoEvent;
  const factory VideoEvent.set(String hls) = _SetVideoEvent;
}

final class _InitVideoEvent extends VideoEvent {
  const _InitVideoEvent();
}

final class _SetVideoEvent extends VideoEvent {
  final String hls;
  const _SetVideoEvent(this.hls);
}

sealed class VideoState {
  const VideoState();
  const factory VideoState.loading() = LoadingVideoState;
  const factory VideoState.success(String url) = SuccessVideoState;
}

final class LoadingVideoState extends VideoState {
  const LoadingVideoState();
}

final class SuccessVideoState extends VideoState {
  final String url;
  const SuccessVideoState(this.url);
}

class VideoBLoC extends Bloc<VideoEvent, VideoState> {
  final _hlsKey = 'hls';
  final ConfigSource _configSource;
  final SettingsSource _settingsSource;

  VideoBLoC({required ConfigSource configSource, required SettingsSource settingsSource})
      : _configSource = configSource,
        _settingsSource = settingsSource,
        super(const VideoState.loading()) {
    on<VideoEvent>(
      (event, emitter) => switch (event) {
        _InitVideoEvent() => _init(emitter),
        _SetVideoEvent(:String hls) => _set(hls, emitter),
      },
    );

    add(const VideoEvent.init());
  }

  void _init(Emitter<VideoState> emitter) {
    emitter(const VideoState.loading());
    final hls = _settingsSource.getString(_hlsKey) ?? '360p';
    String url = _configSource.hlsUrl360p;
    switch (hls) {
      case '1080p':
        url = _configSource.hlsUrl1080p;
        break;
      case '720p':
        url = _configSource.hlsUrl720p;
        break;
      case '480p':
        url = _configSource.hlsUrl480p;
        break;
      case '360p':
      default:
        url = _configSource.hlsUrl360p;
        break;
    }
    emitter(VideoState.success(url));
  }

  void _set(String hls, Emitter<VideoState> emitter) {
    emitter(const VideoState.loading());
    String url = _configSource.hlsUrl360p;
    switch (hls) {
      case '1080p':
        url = _configSource.hlsUrl1080p;
        break;
      case '720p':
        url = _configSource.hlsUrl720p;
        break;
      case '480p':
        url = _configSource.hlsUrl480p;
        break;
      case '360p':
      default:
        url = _configSource.hlsUrl360p;
        break;
    }
    unawaited(_settingsSource.setString(_hlsKey, hls));
    emitter(VideoState.success(url));
  }
}
