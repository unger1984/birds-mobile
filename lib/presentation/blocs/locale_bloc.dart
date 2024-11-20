import 'package:birds/domain/rus_messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl_standalone.dart';
import 'package:timeago/timeago.dart' as timeago;

sealed class LocaleEvent {
  const LocaleEvent();
  const factory LocaleEvent.init() = _InitLocaleEvent;
  const factory LocaleEvent.change(String locale) = _ChangeLocaleEvent;
}

final class _InitLocaleEvent extends LocaleEvent {
  const _InitLocaleEvent();
}

final class _ChangeLocaleEvent extends LocaleEvent {
  final String locale;
  const _ChangeLocaleEvent(this.locale);
}

sealed class LocaleState {
  const LocaleState();
  const factory LocaleState.loading() = LoadingLocaleState;
  const factory LocaleState.success(String locale) = SuccessLocaleState;
}

final class LoadingLocaleState extends LocaleState {
  const LoadingLocaleState();
}

final class SuccessLocaleState extends LocaleState {
  final String locale;
  const SuccessLocaleState(this.locale);
}

class LocaleBLoC extends Bloc<LocaleEvent, LocaleState> {
  LocaleBLoC() : super(const LocaleState.loading()) {
    on<LocaleEvent>(
      (event, emitter) => switch (event) {
        _InitLocaleEvent() => _init(emitter),
        _ChangeLocaleEvent() => _change(event, emitter),
      },
    );

    timeago.setLocaleMessages('ru', const RuMessages());
    add(const LocaleEvent.init());
  }

  Future<void> _init(Emitter<LocaleState> emitter) async {
    emitter(const LocaleState.loading());
    final locale = await findSystemLocale();
    // Тут точно UTF-8
    // ignore: avoid-substring
    final lang = locale.substring(0, 2);
    timeago.setDefaultLocale(lang);
    emitter(LocaleState.success(lang));
  }

  void _change(_ChangeLocaleEvent event, Emitter<LocaleState> emitter) {
    emitter(const LocaleState.loading());
    timeago.setDefaultLocale(event.locale);
    emitter(LocaleState.success(event.locale));
  }
}
