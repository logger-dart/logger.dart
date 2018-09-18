import "context_builder.dart" show ContextBuilderImpl;
import "fields/fields.dart" show Field;
import "interface.dart";
import "logger.dart" show LoggerImpl;

/// [Tracer] used to track time between [Interface.trace] and [Tracer.stop]
/// calls.
abstract class Tracer {
  /// Stops tracing with firing off the completion [message], all further calls
  /// are ignored.
  void stop(String message);
}

class TracerImpl implements Tracer {
  final LoggerImpl _logger;
  final List<Field<Object>> _baseFields;
  final Stopwatch _stopwatch;

  TracerImpl(this._logger, this._baseFields)
      : _stopwatch = Stopwatch()..start();

  @override
  void stop(String message) {
    if (!_stopwatch.isRunning) {
      return;
    }

    _stopwatch.stop();

    (ContextBuilderImpl(_logger, _baseFields)
          ..duration("duration", _stopwatch.elapsed))
        .build()
        .info(message);
  }
}
