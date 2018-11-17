import "package:logger/logger.dart" show Field, FieldKind;

class IntField extends Field<int> {
  IntField(String key, int val) : super(key, val);

  @override
  final FieldKind kind = FieldKind.integer;
}
