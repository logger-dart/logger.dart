import 'dart:collection';
import 'package:logger/logger.dart' show Level, Record;
import 'formatter.dart';

class TextFormatter implements Formatter<String> {
  TextFormatter();

  @override
  String format(Record record) {
    final buf = new StringBuffer();

    _formatLevel(buf, record.level);
    _formatTime(buf, record.time);
    _formatMessage(buf, record.message);
    _formatFields(buf, record.fields);
    _finalize(buf);

    return buf.toString().trim();
  }

  void _formatLevel(buf, Level level) => buf.write('[$level] ');

  void _formatTime(buf, DateTime time) {
    // buf.write();
  }

  void _formatMessage(StringBuffer buf, String message) =>
    buf.write(message.padRight(50));

  void _formatFields(StringBuffer buf, Map<String, dynamic> fields) {
    Map<String, dynamic> _fields =
        new SplayTreeMap<String, dynamic>.from(fields);

    _fields.forEach((k, dynamic v) {
      buf..write('$k=$v')..write(' ');
    });
  }

  void _finalize(StringBuffer buf) => buf.writeln();
}
