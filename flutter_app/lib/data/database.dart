import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift/web.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get itemType => text().check(itemType.isIn(const ['vocab', 'kanji', 'grammar']))();
  TextColumn get term => text()();
  TextColumn get reading => text().nullable()();
  TextColumn get meaning => text()();
  TextColumn get example => text().nullable()();
  TextColumn get tags => text().nullable()();
  TextColumn get createdAt => text()();
}

class Cards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().references(Items, #id)();
  TextColumn get dueDate => text()();
  IntColumn get intervalDays => integer().withDefault(const Constant(0))();
  RealColumn get ease => real().withDefault(const Constant(2.2))();
  IntColumn get lapses => integer().withDefault(const Constant(0))();
  TextColumn get lastGrade => text().nullable()();
  IntColumn get isLeech => integer().withDefault(const Constant(0))();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
}

class Sentences extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().nullable().references(Items, #id)();
  TextColumn get sentence => text()();
  TextColumn get cloze => text().nullable()();
  TextColumn get answer => text().nullable()();
  TextColumn get kind => text().withDefault(const Constant('example'))();
  TextColumn get createdAt => text()();
}

class Errors extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().nullable().references(Items, #id)();
  TextColumn get source => text().check(source.isIn(const ['C', 'D']))();
  TextColumn get errorType => text()();
  TextColumn get note => text().nullable()();
  TextColumn get createdAt => text()();
  IntColumn get resolved => integer().withDefault(const Constant(0))();
}

class Tests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get createdAt => text()();
}

class TestAttempts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get testId => integer().nullable().references(Tests, #id)();
  RealColumn get score => real().withDefault(const Constant(0.0))();
  TextColumn get detailJson => text().nullable()();
  TextColumn get createdAt => text()();
}

class ReviewLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId => integer().references(Cards, #id)();
  TextColumn get grade => text()();
  IntColumn get isCorrect => integer()();
  TextColumn get createdAt => text()();
}

class Attempts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().nullable().references(Items, #id)();
  IntColumn get cardId => integer().nullable().references(Cards, #id)();
  IntColumn get sentenceId => integer().nullable().references(Sentences, #id)();
  IntColumn get testId => integer().nullable().references(Tests, #id)();
  IntColumn get testAttemptId => integer().nullable().references(TestAttempts, #id)();
  TextColumn get source => text().check(source.isIn(const ['srs', 'sentence', 'test', 'quiz', 'manual']))();
  TextColumn get prompt => text().nullable()();
  TextColumn get response => text().nullable()();
  TextColumn get expected => text().nullable()();
  IntColumn get isCorrect => integer().nullable()();
  RealColumn get score => real().nullable()();
  IntColumn get durationMs => integer().nullable()();
  TextColumn get createdAt => text()();
}

class Mistakes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().references(Items, #id)();
  IntColumn get cardId => integer().nullable().references(Cards, #id)();
  TextColumn get source => text().check(source.isIn(const ['srs', 'sentence', 'test', 'quiz', 'manual']))();
  IntColumn get mistakeCount => integer().withDefault(const Constant(1))();
  TextColumn get lastMistakeAt => text()();
  IntColumn get lastAttemptId => integer().nullable().references(Attempts, #id)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {itemId, source},
      ];
}

@DriftDatabase(
  tables: [
    Items,
    Cards,
    Sentences,
    Errors,
    Tests,
    TestAttempts,
    ReviewLogs,
    Attempts,
    Mistakes,
  ],
)
class JPStudyDatabase extends _$JPStudyDatabase {
  JPStudyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _createIndexes();
        },
      );

  Future<void> _createIndexes() async {
    await customStatement('CREATE INDEX IF NOT EXISTS idx_cards_due ON cards(due_date);');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_items_type ON items(item_type);');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_errors_item ON errors(item_id);');
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_review_logs_date ON review_logs(substr(created_at,1,10));',
    );
    await customStatement('CREATE INDEX IF NOT EXISTS idx_attempts_item ON attempts(item_id);');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_attempts_card ON attempts(card_id);');
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_attempts_created ON attempts(substr(created_at,1,10));',
    );
    await customStatement('CREATE INDEX IF NOT EXISTS idx_mistakes_item ON mistakes(item_id);');
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_mistakes_last ON mistakes(last_mistake_at DESC);',
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    if (kIsWeb) {
      return WebDatabase(
        'jpstudy.db',
        setup: (db) {
          db.execute('PRAGMA foreign_keys = ON');
        },
      );
    }

    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'jpstudy.db'));
    return NativeDatabase(
      file,
      setup: (db) {
        db.execute('PRAGMA foreign_keys = ON');
      },
    );
  });
}
