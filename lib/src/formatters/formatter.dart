import "dart:async"
    show Stream, StreamController, StreamSubscription, StreamTransformerBase;

import "package:logger/logger.dart" show Record, Handler;

/// Formatter is used to format log records and used by particular handler.
abstract class Formatter extends StreamTransformerBase<Record, String> {
  StreamController<String> _resultController;
  Stream<Record> _recordStream;
  StreamSubscription<Record> _recordSubscription;

  /// Initializes formatter internals.
  Formatter() {
    _resultController = StreamController(onListen: _listen, onCancel: _cancel);
  }

  void _listen() {
    _recordSubscription = _recordStream.listen((record) {
      final result = call(record);

      _resultController.add(result);
    });
  }

  void _cancel() => _recordSubscription.cancel();

  @override
  Stream<String> bind(Stream<Record> stream) {
    _recordStream = stream;

    return _resultController.stream;
  }

  /// Formats the [record] to particular string representation.
  ///
  /// The [Formatter.call] may not modify the [record].
  String call(Record record);
}
