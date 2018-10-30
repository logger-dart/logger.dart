import "dart:async" show Zone;
import "dart:io" show exit, pid;

import "package:logger/logger.dart" show Field, Interface, Level, Tracer;

import "context_builder.dart" show ContextBuilderImpl;
import "logger.dart";
import "record.dart";
import "tracer.dart";

class Context implements Interface {
  final LoggerImpl _logger;
  final List<Field<Object>> _fields;

  Context(this._logger, [List<Field<Object>> fields])
      : _fields = fields != null ? List.unmodifiable(fields) : null;

  @override
  void log(Level level, String message, [Zone zone]) {
    if (!_logger.isEnabledFor(level)) {
      return;
    }

    zone ??= Zone.current;

    _logger.write(RecordImpl(
        name: _logger.name,
        level: level,
        message: message,
        fields: _fields,
        pid: pid,
        zone: zone));
  }

  @override
  void debug(String message) => log(Level.debug, message);

  @override
  void info(String message) => log(Level.info, message);

  @override
  void warning(String message) => log(Level.warning, message);

  @override
  void error(String message) => log(Level.error, message);

  @override
  void fatal(String message, {bool die = true}) {
    log(Level.fatal, message);

    if (die) {
      exit(1);
    }
  }

  @override
  Tracer trace(String message) {
    ContextBuilderImpl(_logger, _fields)
      ..date("start", DateTime.now())
      ..build().info(message);

    return TracerImpl(_logger, _fields);
  }
}
