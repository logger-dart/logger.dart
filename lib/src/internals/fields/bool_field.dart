import "package:logger/logger.dart" show Field, FieldKind;

class BoolField extends Field<bool> {
  // ignore: avoid_positional_boolean_parameters
  BoolField(String key, bool val) : super(key, val);

  @override
  final FieldKind kind = FieldKind.boolean;
}
