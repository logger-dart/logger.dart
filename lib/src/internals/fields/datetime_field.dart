import "package:logger/logger.dart" show Field, FieldKind;

class DateTimeField extends Field<DateTime> {
  @override
  final FieldKind kind = FieldKind.dateTime;

  DateTimeField(String key, DateTime val) : super(key, val);
}
