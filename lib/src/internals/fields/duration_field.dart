import "package:logger/logger.dart" show Field, FieldKind;

class DurationField extends Field<Duration> {
  DurationField(String key, Duration val) : super(key, val);

  @override
  final FieldKind kind = FieldKind.duration;
}
