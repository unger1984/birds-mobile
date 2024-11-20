import 'package:flutter_bloc/flutter_bloc.dart';

sealed class MainRouterEvent {
  const MainRouterEvent();
  const factory MainRouterEvent.video() = _VideoMainRouterEvent;
  const factory MainRouterEvent.settings() = _SettingsMainRouterEvent;
  const factory MainRouterEvent.about() = _AboutMainRouterEvent;
}

final class _VideoMainRouterEvent extends MainRouterEvent {
  const _VideoMainRouterEvent();
}

final class _SettingsMainRouterEvent extends MainRouterEvent {
  const _SettingsMainRouterEvent();
}

final class _AboutMainRouterEvent extends MainRouterEvent {
  const _AboutMainRouterEvent();
}

sealed class MainRouterState {
  const MainRouterState();
  const factory MainRouterState.video() = VideoMainRouterState;
  const factory MainRouterState.settings() = SettingsMainRouterState;
  const factory MainRouterState.about() = AboutMainRouterState;
}

final class VideoMainRouterState extends MainRouterState {
  const VideoMainRouterState();
}

final class SettingsMainRouterState extends MainRouterState {
  const SettingsMainRouterState();
}

final class AboutMainRouterState extends MainRouterState {
  const AboutMainRouterState();
}

class MainRouterBLoC extends Bloc<MainRouterEvent, MainRouterState> {
  MainRouterBLoC() : super(const MainRouterState.video()) {
    on<MainRouterEvent>(
      (event, emitter) => switch (event) {
        _VideoMainRouterEvent() => _video(emitter),
        _SettingsMainRouterEvent() => _settings(emitter),
        _AboutMainRouterEvent() => _about(emitter),
      },
    );
  }

  void _video(Emitter<MainRouterState> emitter) {
    emitter(const MainRouterState.video());
  }

  void _settings(Emitter<MainRouterState> emitter) {
    emitter(const MainRouterState.settings());
  }

  void _about(Emitter<MainRouterState> emitter) {
    emitter(const MainRouterState.about());
  }
}
