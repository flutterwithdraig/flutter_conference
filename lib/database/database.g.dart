// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ConfEventsCompanion extends UpdateCompanion<ConfEvent> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> image;
  final Value<String> start;
  final Value<String> end;
  final Value<String> speakers;
  final Value<String> updated;
  const ConfEventsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.image = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.speakers = const Value.absent(),
    this.updated = const Value.absent(),
  });
  ConfEventsCompanion.insert({
    required String id,
    required String title,
    required String image,
    required String start,
    required String end,
    required String speakers,
    required String updated,
  })  : id = Value(id),
        title = Value(title),
        image = Value(image),
        start = Value(start),
        end = Value(end),
        speakers = Value(speakers),
        updated = Value(updated);
  static Insertable<ConfEvent> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? image,
    Expression<String>? start,
    Expression<String>? end,
    Expression<String>? speakers,
    Expression<String>? updated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (image != null) 'image': image,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (speakers != null) 'speakers': speakers,
      if (updated != null) 'updated': updated,
    });
  }

  ConfEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? image,
      Value<String>? start,
      Value<String>? end,
      Value<String>? speakers,
      Value<String>? updated}) {
    return ConfEventsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      start: start ?? this.start,
      end: end ?? this.end,
      speakers: speakers ?? this.speakers,
      updated: updated ?? this.updated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (start.present) {
      map['start'] = Variable<String>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<String>(end.value);
    }
    if (speakers.present) {
      map['speakers'] = Variable<String>(speakers.value);
    }
    if (updated.present) {
      map['updated'] = Variable<String>(updated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfEventsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('image: $image, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('speakers: $speakers, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }
}

class $ConfEventsTable extends ConfEvents
    with TableInfo<$ConfEventsTable, ConfEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfEventsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String?> image = GeneratedColumn<String?>(
      'image', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<String?> start = GeneratedColumn<String?>(
      'start', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<String?> end = GeneratedColumn<String?>(
      'end', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _speakersMeta = const VerificationMeta('speakers');
  @override
  late final GeneratedColumn<String?> speakers = GeneratedColumn<String?>(
      'speakers', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  @override
  late final GeneratedColumn<String?> updated = GeneratedColumn<String?>(
      'updated', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, image, start, end, speakers, updated];
  @override
  String get aliasedName => _alias ?? 'conf_events';
  @override
  String get actualTableName => 'conf_events';
  @override
  VerificationContext validateIntegrity(Insertable<ConfEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
          _startMeta, start.isAcceptableOrUnknown(data['start']!, _startMeta));
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
          _endMeta, end.isAcceptableOrUnknown(data['end']!, _endMeta));
    } else if (isInserting) {
      context.missing(_endMeta);
    }
    if (data.containsKey('speakers')) {
      context.handle(_speakersMeta,
          speakers.isAcceptableOrUnknown(data['speakers']!, _speakersMeta));
    } else if (isInserting) {
      context.missing(_speakersMeta);
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    } else if (isInserting) {
      context.missing(_updatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConfEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConfEvent(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image'])!,
      start: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}start'])!,
      end: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}end'])!,
      speakers: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}speakers'])!,
      updated: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated'])!,
    );
  }

  @override
  $ConfEventsTable createAlias(String alias) {
    return $ConfEventsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ConfEventsTable confEvents = $ConfEventsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [confEvents];
}
