import "package:logger/logger.dart" show Handler, Record;

/// [DiscardHandler] is used to discard incoming records.
class DiscardHandler extends Handler {
  @override
  void call(Record record) {}
}
