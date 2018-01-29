import 'dart:async';
import 'package:logger/logger.dart';
import 'package:logger/handlers.dart' show CliHandler;

Future<void> main() async {
  final logger = new Logger()..addHandler(new CliHandler());

  final context = logger.bind(<String, dynamic>{
    'username': 'vanesyan',
    'type': 'image/png',
    'image': 'avatar.png'
  });

  context.info('uploading!');
  final tracer = context.trace('uploaded!');
  await new Future<void>.delayed(new Duration(milliseconds: 1000));
  tracer.stop();
}
