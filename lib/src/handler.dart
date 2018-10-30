import "dart:async" show Future, StreamSubscription;

import "logger.dart" show Logger;
import "record.dart" show Record;

/// Handler is used to handle log [Record]s.
///
/// One handler instance can be bound to only one logger at a time.
abstract class Handler {
  /// Subscription to the logging stream of a [Logger] the handler currently
  /// is bounded to.
  ///
  /// Must be never reassigned directly outside. Should only be used while
  /// call of [Handler.close] to cancel subscription to the stream.
  StreamSubscription<Record> subscription;

  /// Handles incoming [Record]s.
  void call(Record record);

  /// Closes the handler subscription (with appropriated nullification of
  /// underlining [subscription] to prevent further use of freed resources)
  /// and free allocated resources.
  ///
  /// Override the method in concrete [Handler] implementation to
  /// free appropriated resources if necessary.
  ///
  /// It is unnecessary to call this method on handlers individually after
  /// logger close, as it's performed automatically by [Logger.close].
  Future<void> close() => subscription.cancel().then<void>((dynamic _) {
        subscription = null;
      });
}
