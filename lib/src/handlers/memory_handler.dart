import 'package:logger/logger.dart' show Record;
import 'handler.dart';

/// [MemoryHandler] implements in-memory logging [Record]s handler.
/// It keeps sequence of logged records in call order, i.e. when [Record]
/// is created it's simply appended to the list.
/// The main scenario of [MemoryHandler] use - testing purposes.
class MemoryHandler implements Handler {
  /// Logged records.
  final List<Record> records = <Record>[];

  @override
  void call(Record record) {
    records.add(record);
  }
}
