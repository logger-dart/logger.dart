import 'package:logger/handlers.dart' show Handler;
import 'level.dart';
import 'logger.dart' show Context, Logger;

/// [Record] represents a single log entry.
///
/// Whenever [Context.log] or it's descendant methods (i.e. [Context.info],
/// [Context.warning] etc.) called a new [Record] will be created and delegated
/// to the logging [Handler]'s if the record's [level] is equal or higher
/// than the [Logger]'s.
abstract class Record {
  /// Fields been attached to record by specific [Context].
  Map<String, dynamic> get fields;

  /// Severity level.
  Level get level;

  /// Log message.
  String get message;

  /// Time when the record was created.
  DateTime get time;
}

/// An internal implementation of [Record].
class RecordImpl implements Record {
  @override
  final Level level;
  @override
  final String message;
  @override
  final Map<String, dynamic> fields;
  @override
  final DateTime time;

  RecordImpl(this.level, this.message, this.fields) : time = new DateTime.now();
}
