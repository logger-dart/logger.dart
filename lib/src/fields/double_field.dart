import "field.dart";

class DoubleField extends Field<double> {
  @override
  final FieldKind kind = FieldKind.double;

  DoubleField(String key, double val) : super(key, val);
}
