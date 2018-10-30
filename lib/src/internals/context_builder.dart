import "package:logger/logger.dart"
    show ContextBuilder, Field, Interface, Loggable;

import "context.dart";
import "fields/bool_field.dart";
import "fields/datetime_field.dart";
import "fields/double_field.dart";
import "fields/duration_field.dart";
import "fields/int_field.dart";
import "fields/num_field.dart";
import "fields/object_field.dart";
import "fields/string_field.dart";
import "logger.dart";

abstract class _BaseContextBuilder<T> implements ContextBuilder<T> {
  final List<Field<Object>> _fields = [];

  // ignore: avoid_positional_boolean_parameters
  @override
  void boolean(String key, bool val) => _fields.add(BoolField(key, val));

  @override
  void date(String key, DateTime val) => _fields.add(DateTimeField(key, val));

  @override
  void duration(String key, Duration val) =>
      _fields.add(DurationField(key, val));

  @override
  void float(String key, double val) => _fields.add(DoubleField(key, val));

  @override
  void integer(String key, int val) => _fields.add(IntField(key, val));

  @override
  void number(String key, num val) => _fields.add(NumField(key, val));

  @override
  void object(String key, Loggable val) {
    final fields = val.toRecord(PartContextBuilderImpl());

    _fields.add(ObjectField(key, fields));
  }

  @override
  void string(String key, String val) => _fields.add(StringField(key, val));

  @override
  T build();
}

class ContextBuilderImpl extends _BaseContextBuilder<Interface> {
  final LoggerImpl _logger;

  ContextBuilderImpl(this._logger, [List<Field<Object>> fields]) {
    if (fields != null) {
      _fields.addAll(fields);
    }
  }

  @override
  Interface build() => Context(_logger, _fields.isNotEmpty ? _fields : null);
}

class PartContextBuilderImpl
    extends _BaseContextBuilder<List<Field<Object>>> {
  @override
  List<Field<Object>> build() => List.unmodifiable(_fields);
}
