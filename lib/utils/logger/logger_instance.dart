import 'package:flutter/foundation.dart';

@immutable
abstract interface class LoggerInstance {
  void log(Object message);
  void debug(Object? message);
  void info(Object? message);
  void warn(Object? message);
  void error(Object? message, [Object? error, StackTrace? stackTrace]);
  void fatal(Object? message, Object? error, StackTrace? stackTrace);
}
