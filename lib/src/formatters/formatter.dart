import 'package:logger/logger.dart' show Record, LogHandler;

/// Formatter is used to format incoming records in [LogHandler].
typedef Formatter = dynamic Function(Record record);
