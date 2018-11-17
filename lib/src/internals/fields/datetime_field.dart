import "package:logger/logger.dart" show Field, FieldKind;

class DateTimeField extends Field<DateTime> {
  DateTimeField(String key, DateTime val) : super(key, val);

  @override
  final FieldKind kind = FieldKind.dateTime;
}
