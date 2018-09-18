import "field.dart";

class ObjectField extends Field<List<Field<Object>>> {
  @override
  final FieldKind kind = FieldKind.object;

  ObjectField(String key, List<Field<Object>> val) : super(key, val);
}
