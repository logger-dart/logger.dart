import "interface.dart";

/// [Tracer] used to track time between [Interface.trace] and [Tracer.stop]
/// calls.
abstract class Tracer {
  /// Stops tracing with firing off the completion [message], all further calls
  /// are ignored.
  void stop(String message);
}
