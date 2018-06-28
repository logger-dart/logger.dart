import 'package:logger/logger.dart' show Record, LogHandler;

/// [MemoryHandler] implements in-memory logging handler.
///
/// It keeps sequence of logged records in call order, i.e. when [Record]
/// is created it's simply appended to the records list.
///
/// The main scenario of [MemoryHandler] use is testing.
class MemoryHandler implements LogHandler {
  /// Logged records.
  final List<Record> _records = <Record>[];

  /// A list of records fired by the logger on this handler.
  List<Record> get records => List<Record>.unmodifiable(_records);

  @override
  void handleLog(Record record) => _records.add(record);
}
