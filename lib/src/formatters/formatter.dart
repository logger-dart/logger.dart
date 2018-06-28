import 'package:logger/logger.dart' show Record;

abstract class Formatter {
  dynamic format(Record record);
}
