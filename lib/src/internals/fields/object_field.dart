import "package:logger/logger.dart" show Field, FieldKind;

class ObjectField extends Field<List<Field<Object>>> {
  ObjectField(String key, List<Field<Object>> val) : super(key, val);

  @override
  final FieldKind kind = FieldKind.object;
}
