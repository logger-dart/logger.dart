import "dart:async" show Zone;

import "package:logger/logger.dart" show Field, Level, Record;
import "package:meta/meta.dart" show required;

class RecordImpl implements Record {
  RecordImpl({@required this.name,
    @required this.level,
    @required this.message,
    @required this.fields,
    @required this.zone,
    this.pid})
      : time = DateTime.now();

  @override
  final String name;
  @override
  final Level level;
  @override
  final String message;
  @override
  final List<Field<Object>> fields;
  @override
  final DateTime time;
  @override
  final int pid;
  @override
  final Zone zone;
}
