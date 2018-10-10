import "package:logger/logger.dart" show Field, FieldKind;

class NumField extends Field<num> {
  @override
  final FieldKind kind = FieldKind.number;

  NumField(String key, num val) : super(key, val);
}
