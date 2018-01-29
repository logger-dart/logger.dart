import 'logger.dart' show Logger;

/// [Level] controls logging output of [Logger].
///
/// There're 5 predefined [Level]'s sorted in descendant order by
/// severity level, i.e.: [Level.debug], [Level.info], [Level.warning],
/// [Level.error], [Level.fatal].
///
/// It's also possible to disable [Logger] output by setting it [Logger.level]
/// to special level [Level.off]. As opposite to [Level.off], [Level.all]
/// available to make [Logger] to pass logs without throttling 'em.
///
/// While we recommend to use levels available auto of the box, user-defined
/// levels are also supported. When define [Level] make sure
/// it aligns in range between [Level.all] ([value] = 0x0) and
/// [Level.off] ([value] = 0xffff).
class Level implements Comparable<Level> {
  final int value;
  final String name;

  const Level(this.name, this.value);

  static const Level all = const Level('-', 0x0);
  static const Level debug = const Level('debug', 0x1);
  static const Level info = const Level('info', 0x2);
  static const Level warning = const Level('warning', 0x3);
  static const Level error = const Level('error', 0x4);
  static const Level fatal = const Level('fatal', 0x5);
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
  bool operator <(Level o) => value > o.value;

  @override
  String toString() => name;
}
