import "package:logger/logger.dart" show Field, FieldKind;

class StringField extends Field<String> {
  StringField(String key, String val) : super(key, val);

  @override
  final FieldKind kind = FieldKind.string;
}
