import "package:logger/logger.dart" show Record, Handler;

/// [MemoryHandler] implements in-memory logging handler.
///
/// It keeps sequence of logged records in call order, i.e. when [Record]
/// is created it's simply appended to the records list.
///
/// The main scenario of [MemoryHandler] use is testing.
class MemoryHandler extends Handler {
  /// Logged records.
  final List<Record> _records = <Record>[];

  MemoryHandler();

  /// A list of records fired by the logger on this handler.
  List<Record> get records => List<Record>.unmodifiable(_records);

  @override
  void call(Record record) => _records.add(record);
}
