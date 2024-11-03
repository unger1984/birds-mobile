import 'dart:async';
import 'dart:io';

import 'package:birds/domain/app_bloc_observer.dart';
import 'package:birds/presentation/app.dart';
import 'package:birds/utils/logging.dart';
import 'package:birds/utils/service_locator.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:media_kit/media_kit.dart';
import 'package:system_theme/system_theme.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

abstract final class Main {
  static final log = Logger('Main');

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemTheme.accentColor.load();
    await initializeDateFormatting();

    MediaKit.ensureInitialized();

    WakelockPlus.enable();
    if (Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }

    Logging.setup();
    await ServiceLocator.setup();

    Bloc.observer = AppBlocObserver.instance();
    Bloc.transformer = bloc_concurrency.sequential<Object?>();

    runApp(const App());
  }
}

void main() {
  runZonedGuarded<void>(
    () => unawaited(Main.init()),
    (err, stackTrace) => Main.log.shout('Unhandled exception', err, stackTrace),
  );
}
