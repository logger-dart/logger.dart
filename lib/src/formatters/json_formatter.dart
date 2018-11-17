import "dart:convert" show JsonEncoder;

import "package:logger/logger.dart" show Record, Field, FieldKind;

import "formatter.dart" show Formatter;

class JsonFormatter extends Formatter {
  JsonFormatter([String indent])
      : _encoder = JsonEncoder.withIndent(indent),
        super();

  final JsonEncoder _encoder;

  Map<String, Object> _format(List<Field<Object>> fields) {
    if (fields == null) {
      return null;
    }

    final result = <String, Object>{};

    for (final field in fields) {
      switch (field.kind) {
        case FieldKind.boolean:
        case FieldKind.double:
        case FieldKind.integer:
        case FieldKind.number:
        case FieldKind.string:
          result[field.key] = field.value;
          break;

        case FieldKind.duration:
          result[field.key] = (field as Field<Duration> /* DurationField */)
              .value
              .inMicroseconds;
          break;

        case FieldKind.dateTime:
          result[field.key] = (field as Field<DateTime> /* DateTimeField */)
              .value
              .microsecondsSinceEpoch;
          break;

        case FieldKind.object:
          result[field.key] = _format(
              (field as Field<List<Field<Object>>> /* ObjectField */).value);
          break;
      }
    }

    return result;
  }

  @override
  String call(Record record) => _encoder.convert(<String, Object>{
        "name": record.name,
        "level": record.level.toString(),
        "message": record.message,
        "fields": _format(record.fields),
        "time": record.time.microsecondsSinceEpoch,
        "pid": record.pid
      });
}
