import 'package:logger/logger.dart' show Record, LogHandler;
import 'package:logger/formatters.dart' show Formatter, TextFormatter;

class CliHandler implements LogHandler {
  final Formatter formatter;

  CliHandler({this.formatter = const TextFormatter()});

  @override
  void handleLog(Record record) => print(formatter.format(record));
}
