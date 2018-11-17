import "package:logger/logger.dart" show Field, Tracer;

import "context_builder.dart" show ContextBuilderImpl;
import "logger.dart";

class TracerImpl implements Tracer {
  TracerImpl(this._logger, this._baseFields)
      : _stopwatch = Stopwatch()
    ..start();

  final LoggerImpl _logger;
  final List<Field<Object>> _baseFields;
  final Stopwatch _stopwatch;

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
