import "dart:async" show Zone;

import "package:logger/logger.dart";

final _logger = Logger();

/// Sets logging level for logger.
set level(Level level) => _logger.level = level;

/// Returns current logging level of logger.
Level get level => _logger.level;

/// Adds handler to logger.
void addHandler(Handler h) => _logger.addHandler(h);

/// Logs record with [level] and [message] on logger.
void log(Level level, String message, [Zone zone]) =>
    _logger.log(level, message, zone);

/// Logs debug record on logger.
void debug(String message) => _logger.debug(message);

/// Logs info record on logger.
void info(String message) => _logger.info(message);

/// Logs warning record on logger.
void warning(String message) => _logger.warning(message);

/// Logs error record on logger.
void error(String message) => _logger.error(message);

/// Logs fatal record on logger.
void fatal(String message, {bool die = true}) =>
    _logger.fatal(message, die: die);

/// Logs trace record on logger.
Tracer trace(String message) => _logger.trace(message);

/// Creates a new [ContextBuilder] to build a new logging context with logger.
ContextBuilder<Interface> bind() => _logger.bind();
