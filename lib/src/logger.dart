part of logger;

/// Logger represents a logger used to log structural records.
class Logger implements Interface {
  static final Map<String, Logger> _loggers = <String, Logger>{};

  final StreamController<Record> _controller;
  _Context _context;

  /// Name of the logger.
  final String name;

  /// Logging severity level used to filter records fired on the logger.
  Level level;

  /// Creates a new [Logger] instance with specified [name].
  ///
  /// If logging of records are not necessary to be emitted in a strict order
  /// of calls consider set [sync] to `false`.
  ///
  /// Prefer to use [Logger.createLogger] instead of this constructor
  /// as it's caching logger once it's created.
  Logger(this.name, {this.level = Level.info, bool sync = true})
      : _controller = StreamController<Record>.broadcast(sync: !sync) {
    _context = _Context(this, <String, dynamic>{});
  }

  /// Checks if logger with specified [name] has been already created,
  /// if it has been created returns the instance, otherwise creates a
  /// new [Logger] and put to the internal storage, so the instance
  /// will available the next time [Logger.createLogger] will be invoked
  /// with the same [name].
  ///
  /// If Logger hasn't been created before than optional [level] and [sync]
  /// will be used to create a new instance, otherwise they are ignored.
  factory Logger.createLogger(String name,
      {Level level = Level.info, bool sync = true}) {
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
  void addHandler(LogHandler handler) => _onRecord.listen(handler.handleLog);

  Future<dynamic> close() => _controller.close();

  void _flush(Record record) {
    if (_controller != null) {
      _controller.add(record);
    }
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
  void fatal(String message) => _context.fatal(message);
  @override
  Tracer trace(String message) => _context.trace(message);

  /// Creates a  logging context bind to [fields] set.
  Interface withFields(Map<String, dynamic> fields) => _Context(this, fields);

  /// Creates a  logging context bind to [key] and corresponding [value].
  Interface withField(String key, dynamic value) =>
      withFields(<String, dynamic>{key: value});
}
