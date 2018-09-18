import "dart:async" show Completer, Future, StreamController, Stream, Zone;

import "context.dart";
import "context_builder.dart" show ContextBuilder, ContextBuilderImpl;
import "handler.dart";
import "interface.dart";
import "level.dart";
import "record.dart" show Record;
import "tracer.dart" show Tracer;

/// Logger represents a logger used to log structural records.
abstract class Logger implements Interface {
  /// Creates a new [Logger] instance.
  /// Name of the logger.
  final String name;

  /// Logging severity level used to filter records fired on the logger.
  Level level;

  /// Creates a new [Logger] instance with specified [name].
  ///
  /// Optional [name] may be provided, which will be delegated along
  /// all records emitted by this instance.
  ///
  /// Prefer to use [Logger.getLogger] instead of this constructor
  /// as it's caching logger once it's created.
  factory Logger({String name, Level level}) = LoggerImpl;

  /// Checks if logger with specified [name] has been already created,
  /// if it has been created returns the instance, otherwise creates a
  /// new [Logger] and put to the internal storage, so the instance
  /// will available the next time [Logger.getLogger] will be invoked
  /// with the same [name].
  ///
  /// If Logger hasn't been created before, then optional [level]
  /// will be used to create a new instance, otherwise they are ignored.
  factory Logger.getLogger(String name, {Level level}) = LoggerImpl.getLogger;

  /// Adds [Record] handler to the logger by make it listen to the
  /// record stream.
  ///
  /// [handler] must implement [Handler] class.
  void addHandler(Handler handler);
  /// Returns a future that completes when logger is closed.
  Future<void> get done;
  /// Binds returns a new [ContextBuilder] to create field set that is bound
  /// to the logging records emitted by the logging context.
  ContextBuilder<Interface> bind();
      : _controller = StreamController<Record>.broadcast(sync: true),
    if (_loggers.containsKey(name)) {
      return _loggers[name];
    }

    final logger = Logger(name, level: level, sync: sync);
    _loggers[name] = logger;

    return logger;
  }

  Stream<Record> get _onRecord => _controller.stream;

  /// Adds [Record] handler to the logger by make it listen to the
  /// record stream.
  ///
  /// [handler] must implement [LogHandler] class.
  void addHandler(LogHandler handler) => _onRecord.listen(handler);
      _completer.complete();

  Future<dynamic> close() => _controller.close();

  void _flush(Record record) {
    if (_controller != null) {
      _controller.add(record);
    }
  @override
  Future<void> get done => _completer.future;
  @override
  void addHandler(Handler handler) {
    handler.subscription = _onRecord?.listen(handler, onDone: handler.close);
  }

  @override
  void log(Level level, String message, [Zone zone]) =>
      _context.log(level, message, zone);

  @override
  void debug(String message) => _context.debug(message);
  @override
  void info(String message) => _context.info(message);
  @override
  void warning(String message) => _context.warning(message);
  @override
  void error(String message) => _context.error(message);
  @override
  void fatal(String message, {bool die = true}) =>
      _context.fatal(message, die: die);
  @override
  Tracer trace(String message) => _context.trace(message);

  @override
  ContextBuilder<Interface> bind() => ContextBuilderImpl(this);
}
