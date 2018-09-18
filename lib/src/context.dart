import "dart:async" show Zone;
import "dart:io" show exit, pid;
import "context_builder.dart" show ContextBuilderImpl;
import "fields/fields.dart" show Field;
import "interface.dart";
import "level.dart";
import "logger.dart" show LoggerImpl;
import "record.dart" show RecordImpl;
import "tracer.dart";

class _Context implements Interface {
  final Logger _logger;
  final Map<String, dynamic> _fields;

  _Context(this._logger,
      [Map<String, dynamic> fields = const <String, dynamic>{}])
      : _fields = Map<String, dynamic>.unmodifiable(fields);

  @override
  void log(Level level, String message, [Zone zone]) {
    if (_logger.level > level) {
      return;
    }

    zone ??= Zone.current;

    _logger._flush(_Record(_logger.name, level, message, _fields, zone));
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
  void fatal(String message) => log(Level.fatal, message);

  @override
  Tracer trace(String message) {
    final fields = Map<String, dynamic>.from(_fields);
    fields['start'] = DateTime.now();

    _logger.withFields(fields).info(message);

    return Tracer(_logger, _fields);
  }
}
