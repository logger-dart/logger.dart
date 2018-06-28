# Logger
A simple, yet efficient structured logger for Dart.

## Installation
```sh
$ pub get logger
```

Package uses brand new features from Dart 2.0 which is currently in public beta,
in order to use this package make sure that you add `--preview-dart-2` to flags
when running on Dart VM

## Quick Start
```dart
import 'package:logger/logger.dart' show Logger, Tracer;
import 'package:logger/handlers.dart' show CliHandler;

final logger = Logger('example')..addHandler(CliHandler());

void main() {
  final Tracer tracer = logger.withFields({
    'env': 'development',
    'port': 3000
  }).trace('App starts...');
  
  // stuff...
  
  tracer.stop('App started!');
}
```

Find out detailed APIs by the following [link](https://pub.dartlang.org/documentation/logger).

## License
The source is released under the terms of [MIT] license.

[MIT]: ./LICENSE
