import "field.dart";

class DurationField extends Field<Duration> {
  @override
  final FieldKind kind = FieldKind.duration;

  DurationField(String key, Duration val) : super(key, val);
}
