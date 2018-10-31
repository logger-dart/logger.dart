import "dart:async" show Future;

import "package:logger/logger.dart" show Handler, Logger, Record;

class PrintHandler extends Handler {
  @override
  void call(Record record) {
    final result = StringBuffer();
    final fields = StringBuffer();

    for (final field in record.fields) {
      fields.write(" ${field.key}=${field.value}");
    }

    result
      ..write("${record.name} ")
      ..write("${record.time}  ")
      ..write("${record.level.toString().toUpperCase()} ")
      ..write("${record.message}")
      ..write("$fields");

    print(result.toString());
  }
}

void main() async {
  final logger = Logger.getLogger("example.print_handler")
    ..addHandler(PrintHandler());

  final context = (logger.bind()
    ..string("username", "vanesyan")
    ..string("type", "image/png")
    ..string("image", "avatar.png"))
      .build();

  final tracer = context.trace("uploading!");

  await Future<void>.delayed(const Duration(milliseconds: 1000));

  tracer.stop("uploaded!");
}
