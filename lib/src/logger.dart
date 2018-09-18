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

  /// Logging severity level used to filter records fired on the logger.
  Level get level;

  /// Name of the logger, may be `null`.
  String get name;

  /// Set logging severity level.
  ///
  /// It is an error to set `level` to `null`.
  set level(Level level);

  /// Returns `true` if logger is closed, otherwise returns `false`.
  /// It's guaranteed that it returns `true` only after [Logger.close]
  /// invocation.
  bool get isClosed;

  /// Adds [Record] handler to the logger by make it listen to the
  /// record stream.
  ///
  /// [handler] must implement [Handler] class.
  void addHandler(Handler handler);

  /// Returns a future that completes when logger is closed.
  Future<void> get done;

  /// Closes logger. All appended log handlers also are closed appropriately.
  /// Idle for flushes by i/o handlers may occur.
  ///
  /// Future returned by this method is the same future that is returned by
  /// [Logger.done].
  Future<void> close();

  /// Binds returns a new [ContextBuilder] to create field set that is bound
  /// to the logging records emitted by the logging context.
  ContextBuilder<Interface> bind();
}

class LoggerImpl implements Logger {
  static final Map<String, LoggerImpl> _loggers = {};

  final Completer<void> _completer = Completer<void>();
  bool _isClosed = true;
  Context _context;
  Level _level;
  StreamController<Record> _controller;

  @override
  final String name;

  LoggerImpl({this.name, Level level = Level.info})
      : _controller = StreamController<Record>.broadcast(sync: true),
        _isClosed = false {
    _context = Context(this);
    this.level = level;
  }

  factory LoggerImpl.getLogger(String name, {Level level = Level.info}) {
    if (_loggers.containsKey(name)) {
      return _loggers[name];
    }

    final logger = LoggerImpl(name: name, level: level);
    _loggers[name] = logger;

    return logger;
  }

  Stream<Record> get _onRecord => _controller?.stream;

  void _cleanUp() {
    _isClosed = true;
    _controller = null;

    if (name != null) {
      _loggers.remove(name);
    }
  }

  Future<void> _close() {
    if (isClosed) {
      return _completer.future;
    }

    return _controller.close().then<void>((_) {
      _cleanUp();
      _completer.complete();

      return _completer.future;
    });
  }

  void write(Record record) => _controller?.add(record);

  @override
  bool get isClosed => _isClosed;

  @override
  Level get level => _level;

  @override
  set level(Level level) {
    if (level == null) {
      throw ArgumentError.notNull("level");
    }

    _level = level;
  }

  @override
  Future<void> get done => _completer.future;

  @override
  void addHandler(Handler handler) {
    handler.subscription = _onRecord?.listen(handler, onDone: handler.close);
  }

  @override
  Future<void> close() => _close();

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
