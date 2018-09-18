import "field.dart";

class DateTimeField extends Field<DateTime> {
  @override
  final FieldKind kind = FieldKind.dateTime;

  DateTimeField(String key, DateTime val) : super(key, val);
}
