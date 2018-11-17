import "package:logger/logger.dart" show Field, FieldKind;

class NumField extends Field<num> {
  NumField(String key, num val) : super(key, val);

  @override
  final FieldKind kind = FieldKind.number;
}
