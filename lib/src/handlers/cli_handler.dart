import 'package:logger/logger.dart' show Record, LogHandler;
import 'package:logger/formatters.dart' show Formatter, TextFormatter;

// Tests compliance with LogHandler.
final LogHandler _ = CliHandler();

class CliHandler {
  Formatter _formatter;

  CliHandler({Formatter formatter}) {
    if (formatter == null) {
      _formatter = TextFormatter();
    } else {
      _formatter = formatter;
    }
  }

  void call(Record record) => print(_formatter(record));
}
