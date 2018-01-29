import 'dart:collection';
import 'package:logger/logger.dart' show Record;
import 'formatter.dart';

class JsonFormatter implements Formatter<String> {
  JsonFormatter();

  @override
  String format(Record record) {
    final buf = new StringBuffer();

    _formatMessage(buf, record.message);
    _formatFields(buf, record.fields);
    _finalize(buf);

    return buf.toString().trim();
  }

  void _formatMessage(StringBuffer buf, String message) => buf.write(message);

  void _formatFields(StringBuffer buf, Map<String, dynamic> fields) {
    final _fields = new SplayTreeMap<String, dynamic>.from(fields);

    fields.forEach((k, dynamic v) {
      buf..write('$k=$v')..write(' ');
    });
  }

  void _finalize(StringBuffer buf) => buf.writeln();
}
