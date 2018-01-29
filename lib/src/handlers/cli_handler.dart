import 'package:logger/logger.dart' show Record;
import 'package:logger/formatters.dart' show TextFormatter;
import 'handler.dart';

class CliHandler implements Handler {
  final TextFormatter _formatter = new TextFormatter();

  @override
  void call(Record record) {
    print(_formatter.format(record));
  }
}
