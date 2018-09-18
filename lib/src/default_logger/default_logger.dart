import "dart:async" show Zone;

import "package:logger/logger.dart";

/// Singleton logger, default package logger, logs everything by default.
///
/// Use it only for quick tasks as it's always a good idea to create
/// a new [Logger] instance rather than use the default logger.
final Logger logger = Logger(level: Level.all);

/// Set logging level for [logger].
set level(Level level) => logger.level = level;

/// Current logging level of [logger].
Level get level => logger.level;

/// Add handler to [logger].
void addHandler(Handler h) => logger.addHandler(h);

/// Close [logger] logging stream.
void close() => logger.close();

/// Log record with [level] and [message] on [logger].
void log(Level level, String message, [Zone zone]) =>
    logger.log(level, message, zone);

/// Log debug record on [logger].
void debug(String message) => logger.debug(message);

/// Log info record on [logger].
void info(String message) => logger.info(message);

/// Log warning record on [logger].
void warning(String message) => logger.warning(message);

/// Log error record on [logger].
void error(String message) => logger.error(message);

/// Log fatal record on [logger].
void fatal(String message, {bool die = true}) =>
    logger.fatal(message, die: die);

/// Log trace record on [logger].
Tracer trace(String message) => logger.trace(message);

/// Creates a new [ContextBuilder] to build a new logging context with [logger].
ContextBuilder<Interface> bind() => logger.bind();
