import "package:logger/logger.dart" show Field, FieldKind;

class DurationField extends Field<Duration> {
  @override
  final FieldKind kind = FieldKind.duration;

  DurationField(String key, Duration val) : super(key, val);
}
