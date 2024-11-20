import 'dart:async';

import 'package:birds/domain/datasources/settings_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

sealed class SoundEvent {
  const SoundEvent();
  const factory SoundEvent.init() = _InitSoundEvent;
  const factory SoundEvent.change() = _ChangeSoundEvent;
}

final class _InitSoundEvent extends SoundEvent {
  const _InitSoundEvent();
}

final class _ChangeSoundEvent extends SoundEvent {
  const _ChangeSoundEvent();
}

sealed class SoundState {
  const SoundState();
  const factory SoundState.loading() = LoadingSoundState;
  const factory SoundState.play() = PlaySoundState;
  const factory SoundState.pause() = PauseSoundState;
}

final class LoadingSoundState extends SoundState {
  const LoadingSoundState();
}

final class PlaySoundState extends SoundState {
  const PlaySoundState();
}

final class PauseSoundState extends SoundState {
  const PauseSoundState();
}

class SoundBLoC extends Bloc<SoundEvent, SoundState> {
  final _player = AudioPlayer();
  final SettingsSource _settingsSource;

  SoundBLoC({required SettingsSource settingsSource})
      : _settingsSource = settingsSource,
        super(const SoundState.loading()) {
    on<SoundEvent>(
      (event, emitter) => switch (event) {
        _InitSoundEvent() => _init(emitter),
        _ChangeSoundEvent() => _change(emitter),
      },
    );

    add(const SoundEvent.init());
  }

  @override
  Future<void> close() {
    _player.dispose();

    return super.close();
  }

  void _init(Emitter<SoundState> emitter) {
    emitter(const SoundState.loading());
    unawaited(_player.setAsset('assets/mp3/birds.mp3'));
    unawaited(_player.setLoopMode(LoopMode.all));
    final sound = _settingsSource.getBool('music') ?? true;
    if (sound) {
      unawaited(_player.play());
      emitter(const SoundState.play());
    } else {
      unawaited(_player.pause());
      emitter(const SoundState.pause());
    }
  }

  void _change(Emitter<SoundState> emitter) {
    final sound = !(_settingsSource.getBool('music') ?? true);
    unawaited(_settingsSource.setBool('music', sound));
    if (sound) {
      unawaited(_player.play());
      emitter(const SoundState.play());
    } else {
      unawaited(_player.pause());
      emitter(const SoundState.pause());
    }
  }
}
