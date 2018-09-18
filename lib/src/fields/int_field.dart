import "field.dart";

class IntField extends Field<int> {
  @override
  final FieldKind kind = FieldKind.integer;

  IntField(String key, int val) : super(key, val);
}
