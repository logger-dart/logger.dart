import "package:logger/logger.dart" show Field, FieldKind;

class StringField extends Field<String> {
  @override
  final FieldKind kind = FieldKind.string;

  StringField(String key, String val) : super(key, val);
}
