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
  String address;
  double lat;
  double lng;
  int day;

  ConfEvent({
    required this.id,
    required this.title,
    required this.image,
    required this.start,
    required this.end,
    required this.speakers,
    required this.updated,
    required this.address,
    required this.lat,
    required this.lng,
    required this.day,
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
      address: Value(address),
      lat: Value(lat),
      lng: Value(lng),
      day: Value(day),
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
  TextColumn get address => text()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();
  IntColumn get day => integer()();
}
