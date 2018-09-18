import "dart:async" show Zone;

import "fields/fields.dart";
import "interface.dart";
import "level.dart";
import "logger.dart";

/// [Record] represents a single log entry.
///
/// Whenever [Interface.log] or it's derived methods (i.e. [Interface.info],
/// [Interface.warning] etc.) are called a  record will be created and
/// delegated to the appropriated logging handlers if the record's
/// [level] is equal or higher than the [Logger]'s log entry is emitted on.
abstract class Record {
  /// Name of the [Logger] record is fired by.
  String get name;

  /// Severity level.
  Level get level;

  /// Log message.
  String get message;

  /// Fields been attached to record by specific logging context.
  Map<String, dynamic> get fields;

  /// Time when the record was created.
  DateTime get time;

  /// PID of current process.
  int get pid;
  /// Zone of calling code.
  Zone get zone;
}

/// An internal implementation of [Record].
class _Record implements Record {
  @override
  final String name;
  @override
  final Level level;
  @override
  final String message;
  @override
  final Map<String, dynamic> fields;
  @override
  final DateTime time;
  @override
  final int pid;
  @override
  final Zone zone;

  _Record(this.name, this.level, this.message, this.fields, this.zone)
      : time = DateTime.now();
}
