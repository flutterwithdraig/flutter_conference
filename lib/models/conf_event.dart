import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:drift/drift.dart';
import 'package:global_conference/database/database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conf_event.g.dart';

@CopyWith()
@JsonSerializable()
class ConfEvent implements Insertable<ConfEvent> {
  String id;
  String title;
  String image;
  String start;
  String end;
  String speakers;
  String updated;

  ConfEvent({
    required this.id,
    required this.title,
    required this.image,
    required this.start,
    required this.end,
    required this.speakers,
    required this.updated,
  });

  static ConfEvent fromJson(Map<String, dynamic> json) =>
      _$ConfEventFromJson(json);

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ConfEventsCompanion(
      id: Value(id),
      title: Value(title),
      image: Value(image),
      start: Value(start),
      end: Value(end),
      speakers: Value(speakers),
      updated: Value(updated),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(ConfEvent)
class ConfEvents extends Table {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get image => text()();
  TextColumn get start => text()();
  TextColumn get end => text()();
  TextColumn get speakers => text()();
  TextColumn get updated => text()();
}
