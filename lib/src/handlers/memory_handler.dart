import 'package:logger/logger.dart' show Record, LogHandler;

// Tests compliance with [LogHandler].
final LogHandler _ = const MemoryHandler();

/// [MemoryHandler] implements in-memory logging handler.
///
/// It keeps sequence of logged records in call order, i.e. when [Record]
/// is created it's simply appended to the records list.
///
/// The main scenario of [MemoryHandler] use is testing.
class MemoryHandler {
  /// Logged records.
  final List<Record> _records = const <Record>[];

  const MemoryHandler();

  /// A list of records fired by the logger on this handler.
  List<Record> get records => List<Record>.unmodifiable(_records);

  void call(Record record) => _records.add(record);
}
