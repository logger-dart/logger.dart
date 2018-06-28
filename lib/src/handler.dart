part of logger;

/// LogHandler is used to handle log records.
abstract class LogHandler {
  /// Handle incoming record.
  void handleLog(Record record);
}
