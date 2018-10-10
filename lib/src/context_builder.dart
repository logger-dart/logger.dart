import "loggable.dart";

/// [ContextBuilder] is used to build a field set. It is common interface both
/// to build a new logging context with bound field set and to build field set
/// representing custom object that implementing [Loggable].
abstract class ContextBuilder<T> {
  // ignore: avoid_positional_boolean_parameters
  void boolean(String key, bool val);
  void date(String key, DateTime val);
  void duration(String key, Duration val);
  void float(String key, double val);
  void integer(String key, int val);
  void number(String key, num val);
  void object(String key, Loggable val);
  void string(String key, String val);
  T build();
}
