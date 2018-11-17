import "package:logger/logger.dart" show Field, FieldKind;

class DoubleField extends Field<double> {
  DoubleField(String key, double val) : super(key, val);

  @override
  final FieldKind kind = FieldKind.double;
}
