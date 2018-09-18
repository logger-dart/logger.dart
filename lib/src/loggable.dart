import "context_builder.dart" show ContextBuilder;
import "fields/fields.dart" show Field;

abstract class Loggable {
  List<Field<Object>> toRecord(ContextBuilder<List<Field<Object>>> context);
}
