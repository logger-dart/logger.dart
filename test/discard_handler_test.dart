import "package:test/test.dart";
import "package:logger/logger.dart" show Logger;
import "package:logger/handlers.dart" show DiscardHandler;

void main() {
  group("DiscardHandler", () {
    test("It works", () {
      final logger = Logger()..addHandler(DiscardHandler());

      logger.warning("warning");
    });
  });
}
