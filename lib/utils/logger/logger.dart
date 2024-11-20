import 'package:birds/utils/logger/logger_instance.dart';
import 'package:birds/utils/logger/trackit_logger_instance.dart';
import 'package:flutter/material.dart';
import 'package:trackit/trackit.dart';

@immutable
final class Logger {
  static final _internalSingleton = const Logger._internal();

  factory Logger() => _internalSingleton;

  const Logger._internal();
  LoggerInstance create(String title) => TrackitLoggerInstance(Trackit.create(title));
}
