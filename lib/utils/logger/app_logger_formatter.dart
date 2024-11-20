import 'package:flutter/material.dart';
import 'package:trackit/trackit.dart';
import 'package:trackit_console/trackit_console.dart';

@immutable
class AppLoggerFormatter extends TrackitPatternFormater {
  const AppLoggerFormatter()
      : super(
          pattern: '[{L}] <{D}> ({T}): {M}\n{E}\n{S}',
          stringify: _stringifyEvent,
        );

  static String _color(LogEvent event) => switch (event.level) {
        LogLevelTrace() => '37m',
        LogLevelDebug() => '34m',
        LogLevelInfo() => '32m',
        LogLevelWarn() => '33m',
        _ => '31m',
      };

  static LogEventString _stringifyEvent(LogEvent event) {
    final message = event.message?.toString() ?? '';
    final exception = event.exception?.toString() ?? '';
    final stackTrace = event.stackTrace?.toString() ?? '';

    return LogEventString(
      level: '\x1B[${_color(event)}${event.level.name.toUpperCase().characters.getRange(0, 1).toString()}\x1B[0m',
      title: event.title,
      time: event.time.toIso8601String(),
      message:
          message.isNotEmpty ? message.split('\n').map((str) => '\x1B[${_color(event)}$str\x1B[0m').join('\n') : '',
      exception:
          exception.isNotEmpty ? exception.split('\n').map((str) => '\x1B[${_color(event)}$str\x1B[0m').join('\n') : '',
      stackTrace: stackTrace.isNotEmpty
          ? stackTrace.split('\n').map((str) => '\x1B[${_color(event)}$str\x1B[0m').join('\n')
          : '',
    );
  }
}
