import 'package:logger/logger.dart' show Record;

abstract class Formatter<T> {
  T format(Record record);
}
