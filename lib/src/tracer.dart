part of logger;

/// [Tracer] used to track time between [Interface.trace] and [Tracer.stop]
/// calls.
class Tracer {
  final Logger _logger;
  final Map<String, dynamic> _baseFields;
  final Stopwatch _stopwatch = Stopwatch()..start();

  Tracer(this._logger, this._baseFields);

  /// Stops tracing with firing off the completion [message].
  ///
  /// Further calls are ignored.
  void stop(String message) {
    if (!_stopwatch.isRunning) {
      return;
    }

    _stopwatch.stop();

    final fields = Map<String, dynamic>.from(_baseFields);
    fields['duration'] = _stopwatch.elapsed;

    _logger.withFields(fields).info(message);
  }
}
