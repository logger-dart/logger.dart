import "dart:async" show Zone;

import "level.dart";
import "logger.dart" show Logger;
import "record.dart" show Record;
import "tracer.dart";

/// Interface represents an API shared by both [Logger] and
/// field bind context (created by calling [Logger.withFields], etc.).
abstract class Interface {
  /// Puts a [Record] for a [message] with particular severity [level].
  void log(Level level, String message, [Zone zone]);

  /// Logs [message] with [Level.debug] severity level.
  void debug(String message);

  /// Logs [message] with [Level.info] severity level.
  void info(String message);

  /// Logs [message] with [Level.warning] severity level.
  void warning(String message);

  /// Logs [message] with [Level.fatal] severity level.
  void error(String message);

  /// Logs [message] with [Level.fatal] severity.
  void fatal(String message);

  /// Trace returns a  [Tracer] emitting record when [Tracer.stop]
  /// is called with corresponding duration time between [Interface.trace]
  /// and [Tracer.stop] invocations.
  Tracer trace(String message);
}
