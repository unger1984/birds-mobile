import 'package:flutter_bloc/flutter_bloc.dart';

sealed class MainRouterEvent {
  const MainRouterEvent();
  const factory MainRouterEvent.video() = _VideoMainRouterEvent;
  const factory MainRouterEvent.about() = _AboutMainRouterEvent;
}

class _VideoMainRouterEvent extends MainRouterEvent {
  const _VideoMainRouterEvent();
}

class _AboutMainRouterEvent extends MainRouterEvent {
  const _AboutMainRouterEvent();
}

sealed class MainRouterState {
  const MainRouterState();
  const factory MainRouterState.video() = VideoMainRouterState;
  const factory MainRouterState.about() = AboutMainRouterState;
}

class VideoMainRouterState extends MainRouterState {
  const VideoMainRouterState();
}

class AboutMainRouterState extends MainRouterState {
  const AboutMainRouterState();
}

class MainRouterBLoC extends Bloc<MainRouterEvent, MainRouterState> {
  MainRouterBLoC() : super(const MainRouterState.video()) {
    on<MainRouterEvent>(
      (event, emitter) => switch (event) {
        _VideoMainRouterEvent() => _video(emitter),
        _AboutMainRouterEvent() => _about(emitter),
      },
    );
  }

  void _video(Emitter<MainRouterState> emitter) {
    emitter(const MainRouterState.video());
  }

  void _about(Emitter<MainRouterState> emitter) {
    emitter(const MainRouterState.about());
  }
}
