import "discard_handler_test.dart" as discard_handler_test;
import "json_formatter_test.dart" as json_formatter_test;
import "level_test.dart" as level_test;
import "logger_test.dart" as logger_test;

void main() {
  level_test.main();
  logger_test.main();
  json_formatter_test.main();

  discard_handler_test.main();
}
