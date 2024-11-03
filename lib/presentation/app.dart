import 'dart:async';

import 'package:birds/domain/datasources/settings_source.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/blocs/auth_bloc.dart';
import 'package:birds/presentation/blocs/locale_bloc.dart';
import 'package:birds/presentation/blocs/main_router.dart';
import 'package:birds/presentation/blocs/ws_cubit.dart';
import 'package:birds/presentation/sceens/video/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:system_theme/system_theme.dart';

@immutable
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _localeBLoC = LocaleBLoC();
  final _wsCubit = WsCubit(wsRepository: GetIt.I<WsRepository>());

  @override
  dispose() {
    unawaited(_localeBLoC.close());
    unawaited(_wsCubit.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleBLoC>.value(value: _localeBLoC),
        BlocProvider<WsCubit>.value(value: _wsCubit),
        BlocProvider<MainRouterBLoC>(create: (context) => MainRouterBLoC()),
        BlocProvider<AuthBLoC>(
          create: (context) => AuthBLoC(
            wsCubit: _wsCubit,
            wsRepository: GetIt.I<WsRepository>(),
            settingsSource: GetIt.I<SettingsSource>(),
          ),
        ),
      ],
      child: BlocBuilder<LocaleBLoC, LocaleState>(
        builder: (context, state) => switch (state) {
          SuccessLocaleState(:String locale) => MaterialApp(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Locale.fromSubtags(languageCode: locale),
              supportedLocales: S.delegate.supportedLocales,
              onGenerateTitle: (context) => S.of(context).title,
              restorationScopeId: 'root',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: SystemTheme.accentColor.accent,
                ),
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: SystemTheme.accentColor.accent,
                  brightness: Brightness.dark,
                ),
              ),
              home: BlocBuilder<MainRouterBLoC, MainRouterState>(
                // Так удобнее чем заводить новый виджет.
                // ignore: avoid-nested-switch-expressions
                builder: (context, route) => switch (route) {
                  VideoMainRouterState() => const VideoScreen(),
                  _ => const SizedBox(),
                },
              ),
            ),
          _ => const SizedBox(),
        },
      ),
    );
  }
}
