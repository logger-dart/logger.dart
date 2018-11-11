import "dart:io" show stdout, stderr;

import "package:logger/formatters.dart" show Formatter;
import "package:logger/logger.dart" show Level, Record, Handler;
import "package:meta/meta.dart" show required;

/// Levels are subjected to delegate to [stderr].
const List<Level> _defaultStderrLevels = <Level>[
  Level.warning,
  Level.error,
  Level.fatal
];

/// ConsoleHandler is a log handler for outputting to console (stdout/stderr).
class ConsoleHandler extends Handler {
  final Formatter _formatter;
  final Set<Level> _stderrLevels;
  bool _silent;

  /// Creates a new [ConsoleHandler] instance with optional [formatter].
  ///
  /// Only [Record]s with [Level.warning], [Level.error] and [Level.fatal]
  /// levels are emitted to [stderr] by default, to change this behavior
  /// override [stderrLevels] with custom levels list. All [Record] with levels
  /// other than that are provided in [stderrLevels] are delegated to [stdout].
  ///
  /// To disable output of the handler set [silent] to `true`.
  ConsoleHandler(
      {@required Formatter formatter,
      bool silent = false,
      List<Level> stderrLevels = _defaultStderrLevels})
      : assert(silent != null),
        assert(formatter != null),
        _formatter = formatter,
        _silent = silent,
        _stderrLevels = Set<Level>.from(stderrLevels ?? <Level>[]);

  /// Returns if silent mode is on.
  bool get silent => _silent;

  /// Enables or disables silent mode.
  ///
  /// If `null` is provided an error will be thrown.
  set silent(bool silent) {
    if (silent == null) {
      throw ArgumentError.notNull("silent");
    }

    _silent = silent;
  }

  @override
  void call(Record record) {
    if (silent) {
      return;
    }

    final message = _formatter(record);

    // TODO: should we use nonBlocking channel for stdout/stderr?
    if (_stderrLevels.contains(record.level)) {
      stderr.writeln(message);
    } else {
      stdout.writeln(message);
    }
  }
}
