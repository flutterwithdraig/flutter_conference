import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:global_conference/models/conf_event.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [ConfEvents])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ConfEvents
  Stream<List<ConfEvent>> watchConfEvents() => (select(confEvents)).watch();

  Future<void> insertEvent(ConfEvent event) =>
      into(confEvents).insertOnConflictUpdate(event);

  Future<ConfEvent?> getLastUpdated() => (select(confEvents)
        ..orderBy([
          (e) => OrderingTerm(expression: e.updated, mode: OrderingMode.desc)
        ])
        ..limit(1))
      .getSingleOrNull();

  @override
  Future<void> close() {
    close();
    return super.close();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final folder = await getApplicationDocumentsDirectory();
    final file = File(p.join(folder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
