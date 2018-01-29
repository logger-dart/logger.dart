import 'logger.dart';

/// [Tracer] used to track time between [Context.trace] and [Tracer.stop]
/// calls respectively.
class Tracer {
  Logger _logger;
  final DateTime _start;
  final String _message;
  final Map<String, dynamic> _fields;

  Tracer(this._logger, this._message, Map<String, dynamic> fields)
      : _fields = new Map<String, dynamic>.from(fields),
        _start = new DateTime.now();

  /// Stops tracing with firing off the completion message.
  void stop() {
    final duration = new DateTime.now().difference(_start);
    _fields['duration'] = duration;

    return _logger.bind(_fields).info(_message);
  }
}
