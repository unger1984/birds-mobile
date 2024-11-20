import 'package:birds/utils/logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  static final _log = Logger().create('AppBlocObserver');
  static AppBlocObserver? _instance;

  factory AppBlocObserver.instance() => _instance ??= const AppBlocObserver._();
  const AppBlocObserver._();

  @override
  // Тут так нужно.
  // ignore:avoid-dynamic
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _log.error('Unhandled bloc exception', error, stackTrace);
  }
}
