import "package:logger/formatters.dart";
import "package:logger/logger.dart";
import "package:test/test.dart";

class _StringHandler extends Handler {
  _StringHandler(this.formatter)
      : records = [],
        super();

  final Formatter formatter;
  final List<String> records;
  
  @override
  void call(Record record) => records.add(formatter(record));
}

class _Object extends Loggable {
  @override
  List<Field<Object>> toRecord(ContextBuilder<List<Field<Object>>> context) =>
      (context
            ..boolean("object-bool_field", true)
            ..float("object-float_field", 3.14))
          .build();
}

void main() {
  group("JsonFormatter", () {
    test("It works", () {
      final handler = _StringHandler(JsonFormatter());
      final logger = Logger()
        ..level = Level.all
        ..addHandler(handler);

      final context = (logger.bind()
            ..string("string_field", "string")
            ..date("date_field", DateTime.now())
            ..object("object_field", _Object()))
          .build();

      context.info("Info");
      context.warning("Warning");
    });
  });
}
