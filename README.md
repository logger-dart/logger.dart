![Linux build][travis-badge-url] ![Code coverage][coveralls-badge-url] [![Docs reference][dartdocs-badge-url]][dartdocs-url]

Logger is an efficient structured logger for Dart.

### Installation
The process of installation is very common and only requires `pub` to be installed
on the machine.

```sh
$ pub get logger
```

_Make sure you are running on Dart 2.1 or greater, as logger is currently limits
support only to this platform._

### Quick Start
Once package is installed on the machine you are ready to getting started,
here is a quick example you can use:

```dart
import "dart:async" show Future;

import "package:logger/logger.dart" show Logger;
import "package:logger/handlers.dart" show ConsoleHandler;

void main() async {
  final logger = Logger.getLogger("example.console")
    ..addHandler(ConsoleHandler());

  final context = (logger.bind()
        ..string("username", "vanesyan")
        ..string("type", "image/png")
        ..string("image", "avatar.png"))
      .build();

  final tracer = context.trace("uploading!");

  await Future<void>.delayed(const Duration(milliseconds: 1000));

  tracer.stop("uploaded!");
}
```

The logger package comes with a bunch of log records handlers that are available
at the `handlers` package entry; e.g. `ConsoleHandler`, `FileHandler`, etc.

By the way the `logger` package also exposes a `default_logger` entry which provides
a top-level logger used to quick start.

```dart
import "dart:async" show Future;

import "package:logger/default_logger.dart" as log;
import "package:logger/handlers.dart" show ConsoleHandler;

void main() {
  log.addHandler(ConsoleHandler());

  log.info("Hello world!");
}
```

Logger provided by the `default_logger` package entry shares the same API as the
`Logger` available from `logger` package entry, with exception that the former cannot
be closed.

You can find out more about API by following the [link][dartdocs-url].

## License
The source code is released under the terms of [MIT] license.

[MIT]: ./LICENSE
[travis-badge-url]: https://img.shields.io/travis/logger-dart/logger.dart/master.svg
[coveralls-badge-url]: https://img.shields.io/coveralls/github/logger-dart/logger.dart/master.svg
[dartdocs-badge-url]: https://img.shields.io/badge/dartdocs-reference-blue.svg
[dartdocs-url]: https://pub.dartlang.org/documentation/logger
