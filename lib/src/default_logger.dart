part of logger;

/// Singleton logger, default package logger, loges everything by default.
///
/// Use it only for quick tasks as it's always a good idea to create
/// a new [Logger] instance rather than use the default logger.
final Logger defaultLogger = Logger('DefaultLogger', level: Level.all);

/// Set logging level for [defaultLogger].
set level(Level level) => defaultLogger.level = level;

/// Current logging level of [defaultLogger].
Level get level => defaultLogger.level;

/// Add handler to [defaultLogger].
void addHandler(LogHandler h) => defaultLogger.addHandler(h);

/// Close [defaultLogger] logging stream.
void close() => defaultLogger.close();

/// Log record with [level] and [message] on [defaultLogger].
void log(Level level, String message, [Zone zone]) =>
    defaultLogger.log(level, message, zone);

/// Log debug record on [defaultLogger].
void debug(String message) => defaultLogger.debug(message);

/// Log info record on [defaultLogger].
void info(String message) => defaultLogger.info(message);

/// Log warning record on [defaultLogger].
void warning(String message) => defaultLogger.warning(message);

/// Log error record on [defaultLogger].
void error(String message) => defaultLogger.error(message);

/// Log fatal record on [defaultLogger].
void fatal(String message) => defaultLogger.fatal(message);

/// Log trace record on [defaultLogger].
Tracer trace(String message) => defaultLogger.trace(message);

/// Creates a new context bind to [fields] with [defaultLogger].
Interface withFields(Map<String, dynamic> fields) =>
    defaultLogger.withFields(fields);

/// Creates a new context bind to [key], [value] with [defaultLogger].
Interface withField(String key, dynamic value) =>
    withFields(<String, dynamic>{key: value});
