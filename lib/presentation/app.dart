import 'dart:async';

import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/blocs/locale_bloc.dart';
import 'package:birds/presentation/blocs/ws_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

@immutable
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _localeBLoC = LocaleBLoC();

  @override
  dispose() {
    unawaited(_localeBLoC.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleBLoC>.value(value: _localeBLoC),
        BlocProvider<WsCubit>(
          create: (context) => WsCubit(wsRepository: GetIt.I<WsRepository>()),
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
              theme: ThemeData(primarySwatch: Colors.blueGrey),
              home: Scaffold(
                body: BlocBuilder<WsCubit, WsCubitState>(
                  // Временно
                  // ignore: avoid-nested-switch-expressions
                  builder: (context, state) => switch (state) {
                    LoadingWsCubitState() => const Center(child: CircularProgressIndicator()),
                  },
                ),
              ),
            ),
          _ => const SizedBox(),
        },
      ),
    );
  }
}
