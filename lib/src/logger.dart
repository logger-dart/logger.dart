import 'dart:async';
import 'package:logger/handlers.dart' show Handler;
import 'level.dart';
import 'record.dart';
import 'tracer.dart';

/// Context provides single logging context.
abstract class Context {
  void log(Level level, String message);
  void debug(String message);
  void info(String message);
  void warning(String message);
  void error(String message);
  void fatal(String message);
  Tracer trace(String message);
}

class _Context implements Context {
  final Logger _logger;
  final Map<String, dynamic> _fields;

  _Context(this._logger, [Map<String, dynamic> fields])
      : _fields = new Map<String, dynamic>.from(fields ?? <String, dynamic>{});

  @override
  void log(Level level, String message) => _logger._flush(this, level, message);
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
  Tracer trace(String message) => new Tracer(this._logger, message, _fields);

  Record _finalize(Level level, String message) =>
      new RecordImpl(level, message, _fields);
}

class Logger implements Context {
  final StreamController<Record> _controller =
      new StreamController<Record>.broadcast(sync: true);
  _Context _context;

  final String name;
  Level level;

  Logger({this.name = "", this.level = Level.info}) {
    _context = new _Context(this);
  }

  Stream<Record> get _onRecord => _controller.stream;

  void addHandler(Handler h) => _onRecord.listen(h);

  void _flush(_Context context, Level level, String message) {
    if (this.level > level) {
      return;
    }

    _controller.add(context._finalize(level, message));
  }

  @override
  void log(Level level, String message) => _context.log(level, message);
  @override
  void debug(String message) => _context.debug(message);
  @override
  void info(String message) => _context.info(message);
  @override
  void warning(String message) => _context.warning(message);
  @override
  void error(String message) => _context.error(message);
  @override
  void fatal(String message) => _context.fatal(message);
  @override
  Tracer trace(String message) => _context.trace(message);

  Context bind(Map<String, dynamic> fields) => new _Context(this, fields);
}
