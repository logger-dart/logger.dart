import "logger.dart";

/// [Level] controls logging output of [Logger].
///
/// There're 5 predefined [Level]'s sorted in descendant order by
/// severity level, i.e.: [Level.debug], [Level.info], [Level.warning],
/// [Level.error], [Level.fatal].
///
/// It's also possible to disable [Logger] output by setting it's [Logger.level]
/// to special level - [Level.off]. As opposite to [Level.off], [Level.all]
/// available to make [Logger] to pass logs without throttling them at all.
///
/// While we recommend to use levels available auto of the box, user-defined
/// levels are also supported. When define [Level] make sure
/// it aligns in range between [Level.all] ([value] = 0x0) and
/// [Level.off] ([value] = 0xffff).
class Level implements Comparable<Level> {
  final String name;

  /// Unique value used to identify the level.
  final int value;

  const Level(this.name, this.value);

  /// Logging level to turn on logging of all levels.
  static const Level all = const Level('-', 0x0);

  /// Logging level for debugging messages.
  static const Level debug = const Level('debug', 0x1);

  /// Logging level for informative messages.
  static const Level info = const Level('info', 0x2);

  /// Logging level for potential errors.
  static const Level warning = const Level('warning', 0x3);

  /// Logging level for errors.
  static const Level error = const Level('error', 0x4);

  /// Logging level for fatal errors, leads to process exit.
  static const Level fatal = const Level('fatal', 0x5);

  /// Logging level to completely turn off logging.
  static const Level off = const Level('-', 0xffff);

  @override
  int get hashCode => value;

  @override
  int compareTo(Level o) => value - o.value;

  @override
  bool operator ==(dynamic o) => o is Level && o.value == value;
  bool operator >=(Level o) => value >= o.value;
  bool operator >(Level o) => value > o.value;
  bool operator <=(Level o) => value <= o.value;
  bool operator <(Level o) => value < o.value;

  @override
  String toString() => name;
}
