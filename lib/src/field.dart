enum FieldKind {
  boolean,
  dateTime,
  duration,
  double,
  integer,
  number,
  object,
  string,
}

abstract class Field<V> {
  Field(this.key, this.value);

  final String key;
  final V value;

  /// Kind of the field value (i.e. type of value).
  FieldKind get kind;
}
