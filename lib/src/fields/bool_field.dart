import "field.dart";

class BoolField extends Field<bool> {
  @override
  final FieldKind kind = FieldKind.boolean;

  BoolField(String key, bool val) : super(key, val);
}
