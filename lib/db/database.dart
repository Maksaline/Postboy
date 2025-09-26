import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Requests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withDefault(const Constant('New Request'))();
  TextColumn get url => text().withDefault(const Constant(''))();
  TextColumn get method => text().withDefault(const Constant('GET'))();
  TextColumn get body => text().nullable()();
  TextColumn get expectedResponse => text().nullable()();
  TextColumn get automation => text().nullable()();
  TextColumn get authToken => text().nullable()();
  TextColumn get headers => text().nullable()();
  IntColumn get count => integer().nullable()();
  BoolColumn get jsonOn => boolean().withDefault(const Constant(false))();
  BoolColumn get authOn => boolean().withDefault(const Constant(false))();
  BoolColumn get expectedOn => boolean().withDefault(const Constant(false))();
  BoolColumn get automationOn => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

@DriftDatabase(tables: [Requests])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'goals_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}