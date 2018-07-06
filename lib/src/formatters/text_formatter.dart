import 'dart:collection' show SplayTreeMap;
import 'package:logger/logger.dart' show Level, Record;
import 'formatter.dart';

// Tests compliance with `Formatter` type.
final Formatter _ = TextFormatter();

class TextFormatter {
  final bool isColored;

  TextFormatter({this.isColored = true});

  String call(Record record) {
    final buf = StringBuffer();

    _formatName(buf, record.name);
    _formatLevel(buf, record.level);
    _formatTime(buf, record.time);
    _formatMessage(buf, record.message);
    _formatFields(buf, record.fields);

    return _finalize(buf);
  }

  void _formatName(StringBuffer buf, String name) => buf.write('$name ');
  void _formatLevel(StringBuffer buf, Level level) => buf.write('$level ');
  void _formatTime(StringBuffer buf, DateTime time) => buf.write('[$time] ');

  void _formatMessage(StringBuffer buf, String message) =>
      buf.write(message.padRight(40));

  void _formatFields(StringBuffer buf, Map<String, dynamic> fields) {
    // Splay map is used here to alphabetically order fields;
    // complexity: O(nlogn).
    SplayTreeMap<String, dynamic>.from(fields)
        .forEach((k, dynamic v) => buf.write(' $k=$v'));
  }

  String _finalize(StringBuffer buf) {
    buf.writeln();
    return buf.toString().trim();
  }
}
