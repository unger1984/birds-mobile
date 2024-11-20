import 'package:birds/utils/logger/logger_instance.dart';
import 'package:flutter/foundation.dart';
import 'package:trackit/trackit.dart';

@immutable
final class TrackitLoggerInstance implements LoggerInstance {
  final TrackitInstance _instance;

  const TrackitLoggerInstance(this._instance);

  @override
  void debug(Object? message) => _instance.debug(message);

  @override
  void error(Object? message, [Object? error, StackTrace? stackTrace]) => _instance.error(message, error, stackTrace);

  @override
  void fatal(Object? message, Object? error, StackTrace? stackTrace) => _instance.fatal(message, error, stackTrace);

  @override
  void info(Object? message) => _instance.info(message);

  @override
  void log(Object message) => _instance.log(message);

  @override
  void warn(Object? message) => _instance.warn(message);
}
