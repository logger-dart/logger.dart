import "package:test/test.dart";
import "package:logger/logger.dart";

void main() {
  group("Level", () {
    test("operators to be consistent", () {
      const level1 = Level("TestLevel-1", 0xfff);
      const level2 = Level("TestLevel-2", 0xff);

      expect(level1 == level1, isTrue);
      expect(level1 <= level1, isTrue);
      expect(level1 >= level1, isTrue);
      expect(level1 > level1, isFalse);
      expect(level1 < level1, isFalse);

      expect(level1 == level2, isFalse);
      expect(level1 <= level2, isFalse);
      expect(level1 >= level2, isTrue);
      expect(level1 > level2, isTrue);
      expect(level1 < level2, isFalse);
    });

    test("to be comparable", () {
      const sortedLevels = <Level>[
        Level.all,
        Level.debug,
        Level.info,
        Level.warning,
        Level.error,
        Level.fatal,
        Level.off
      ];

      final levels = <Level>[
        Level.error,
        Level.debug,
        Level.warning,
        Level.info,
        Level.off,
        Level.fatal,
        Level.all
      ];

      expect(levels, isNot(orderedEquals(sortedLevels)));

      levels.sort();
      expect(levels, orderedEquals(sortedLevels));
    });

    test("are hashable", () {
      final levels = <Level, String>{};

      levels[Level.error] = "error";
      levels[Level.info] = "info";

      expect(levels[Level.error], same("error"));
      expect(levels[Level.info], same("info"));
    });
  });
}
