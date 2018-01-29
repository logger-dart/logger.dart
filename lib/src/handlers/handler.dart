import 'package:logger/logger.dart' show Record;

/// [Handler] is an adapter to use implementation class as log handler.
abstract class Handler {
  void call(Record record);
}
