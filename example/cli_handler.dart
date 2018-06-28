import 'dart:async';
import 'package:logger/logger.dart';
import 'package:logger/handlers.dart' show CliHandler;

Future<void> main() async {
  final logger = Logger.createLogger('Example')..addHandler(CliHandler());

  final context = logger.withFields(<String, dynamic>{
    'username': 'vanesyan',
    'type': 'image/png',
    'image': 'avatar.png'
  });

  final tracer = context.trace('uploading!');
  await Future<void>.delayed(const Duration(milliseconds: 1000));
  tracer.stop('uploaded!');
}
