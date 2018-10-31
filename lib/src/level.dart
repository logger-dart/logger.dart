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
/// [Level.off] ([value] = 0xfffff).
class Level implements Comparable<Level> {
  /// Name of the level.
  final String name;

  /// Unique value used to identify the level.
  final int value;

  const Level(this.name, this.value);

  /// Logging level to turn on logging of all levels.
  static const Level all = Level("-", 0x0);

  /// Logging level for debugging messages.
  static const Level debug = Level("debug", 0x1);

  /// Logging level for informative messages.
  static const Level info = Level("info", 0xf);

  /// Logging level for potential errors.
  static const Level warning = Level("warning", 0xff);

  /// Logging level for errors.
  static const Level error = Level("error", 0xfff);

  /// Logging level for fatal errors, leads to process exit.
  static const Level fatal = Level("fatal", 0xffff);

  /// Logging level to completely turn off logging.
  static const Level off = Level("-", 0xfffff);

  @override
  int get hashCode => value;

  @override
  bool operator ==(Object other) =>
      other is Level && value == other.value;

  bool operator >=(Level other) => value >= other.value;

  bool operator >(Level other) => value > other.value;

  bool operator <=(Level other) => value <= other.value;

  bool operator <(Level other) => value < other.value;

  @override
  int compareTo(Level other) => value - other.value;

  @override
  String toString() => name;
}
