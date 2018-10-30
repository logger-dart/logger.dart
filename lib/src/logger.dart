import "dart:async" show Future;

import "package:logger/src/context_builder.dart" show ContextBuilder;
import "package:logger/src/handler.dart";
import "package:logger/src/interface.dart";
import "package:logger/src/level.dart";
import "package:logger/src/record.dart" show Record;

import "internals/logger.dart" show LoggerImpl;

/// Logger represents a logger used to log structural records.
abstract class Logger implements Interface {
  /// Creates a new [Logger] instance.
  ///
  /// Optional [name] may be provided, which will be delegated along
  /// all records emitted by this instance.
  ///
  /// Prefer to use [Logger.getLogger] instead of this constructor
  /// as it's caching logger once it's created.
  factory Logger({String name}) = LoggerImpl;

  /// Checks if logger with specified [name] has been already created,
  /// if it has been created returns the instance, otherwise creates a
  /// new [Logger] and put to the internal storage, so the instance
  /// will available the next time [Logger.getLogger] will be invoked
  /// with the same [name].
  factory Logger.getLogger(String name) = LoggerImpl.getLogger;

  /// Logging severity level used to filter records fired on the logger.
  Level get level;

  /// Name of the logger, if no name was provided empty string is returned.
  String get name;

  /// Set logging severity level.
  ///
  /// It is an error to set `level` to `null`.
  set level(Level level);

  /// Returns `true` if logger is closed, otherwise returns `false`.
  /// It's guaranteed that it returns `true` only after [Logger.close]
  /// invocation.
  bool get isClosed;

  /// Returns a future that completes when logger is closed.
  Future<void> get done;

  /// Adds [Record] handler to the logger by make it listen to the
  /// record stream.
  ///
  /// [handler] must implement [Handler] class.
  void addHandler(Handler handler);

  /// Checks if the message with provided severity [level] will be processed
  /// by the logger.
  bool isEnabledFor(Level level);

  /// Closes logger. All appended log handlers also are closed appropriately.
  /// Idle for flushes by i/o handlers may occur.
  ///
  /// Future returned by this method equals to future that is returned by
  /// [Logger.done].
  Future<void> close();

  /// Binds returns a new [ContextBuilder] to create field set that is bound
  /// to the logging records emitted by the logging context.
  ContextBuilder<Interface> bind();
}
