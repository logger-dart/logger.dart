import "context.dart";
import "fields/fields.dart";
import "interface.dart";
import "loggable.dart";
import "logger.dart" show LoggerImpl;

/// [ContextBuilder] is used to build a field set. It is common interface both
/// to build a new logging context with bound field set and to build field set
/// representing custom object that implementing [Loggable].
abstract class ContextBuilder<T> {
  final List<Field<Object>> _fields = [];

  void boolean(String key, bool val) => _fields.add(BoolField(key, val));

  void date(String key, DateTime val) => _fields.add(DateTimeField(key, val));

  void duration(String key, Duration val) =>
      _fields.add(DurationField(key, val));

  void float(String key, double val) => _fields.add(DoubleField(key, val));

  void integer(String key, int val) => _fields.add(IntField(key, val));

  void number(String key, num val) => _fields.add(NumField(key, val));

  void object(String key, Loggable val) {
    final fields = val.toRecord(PartContextBuilderImpl());

    _fields.add(ObjectField(key, fields));
  }

  void string(String key, String val) => _fields.add(StringField(key, val));

  T build();
}

class ContextBuilderImpl extends ContextBuilder<Interface> {
  final LoggerImpl _logger;

  ContextBuilderImpl(this._logger, [List<Field<Object>> fields]) {
    if (fields != null) {
      _fields.addAll(fields);
    }
  }

  @override
  Interface build() => Context(_logger, _fields);
}

class PartContextBuilderImpl extends ContextBuilder<List<Field<Object>>> {
  @override
  List<Field<Object>> build() => List.unmodifiable(_fields);
}
