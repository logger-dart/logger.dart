import "dart:async";

import "package:logger/formatters.dart" show JsonFormatter;
import "package:logger/handlers.dart" show ConsoleHandler;
import "package:logger/logger.dart" show Logger;

Future<void> main() async {
  final logger = Logger.getLogger("example.console")
    ..addHandler(ConsoleHandler(formatter: JsonFormatter()));

  final context = (logger.bind()
        ..string("username", "vanesyan")
        ..string("type", "image/png")
        ..string("image", "avatar.png"))
      .build();

  final tracer = context.trace("uploading!");
  await Future<void>.delayed(const Duration(seconds: 1));
  tracer.stop("uploaded!");
}
