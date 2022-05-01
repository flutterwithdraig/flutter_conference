// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conf_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfEventCWProxy {
  ConfEvent address(String address);

  ConfEvent day(int day);

  ConfEvent end(String end);

  ConfEvent id(String id);

  ConfEvent image(String image);

  ConfEvent lat(double lat);

  ConfEvent lng(double lng);

  ConfEvent speakers(String speakers);

  ConfEvent start(String start);

  ConfEvent title(String title);

  ConfEvent updated(String updated);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfEvent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfEvent(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfEvent call({
    String? address,
    int? day,
    String? end,
    String? id,
    String? image,
    double? lat,
    double? lng,
    String? speakers,
    String? start,
    String? title,
    String? updated,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfEvent.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfEvent.copyWith.fieldName(...)`
class _$ConfEventCWProxyImpl implements _$ConfEventCWProxy {
  final ConfEvent _value;

  const _$ConfEventCWProxyImpl(this._value);

  @override
  ConfEvent address(String address) => this(address: address);

  @override
  ConfEvent day(int day) => this(day: day);

  @override
  ConfEvent end(String end) => this(end: end);

  @override
  ConfEvent id(String id) => this(id: id);

  @override
  ConfEvent image(String image) => this(image: image);

  @override
  ConfEvent lat(double lat) => this(lat: lat);

  @override
  ConfEvent lng(double lng) => this(lng: lng);

  @override
  ConfEvent speakers(String speakers) => this(speakers: speakers);

  @override
  ConfEvent start(String start) => this(start: start);

  @override
  ConfEvent title(String title) => this(title: title);

  @override
  ConfEvent updated(String updated) => this(updated: updated);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfEvent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfEvent(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfEvent call({
    Object? address = const $CopyWithPlaceholder(),
    Object? day = const $CopyWithPlaceholder(),
    Object? end = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
    Object? speakers = const $CopyWithPlaceholder(),
    Object? start = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? updated = const $CopyWithPlaceholder(),
  }) {
    return ConfEvent(
      address: address == const $CopyWithPlaceholder() || address == null
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String,
      day: day == const $CopyWithPlaceholder() || day == null
          ? _value.day
          // ignore: cast_nullable_to_non_nullable
          : day as int,
      end: end == const $CopyWithPlaceholder() || end == null
          ? _value.end
          // ignore: cast_nullable_to_non_nullable
          : end as String,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      lat: lat == const $CopyWithPlaceholder() || lat == null
          ? _value.lat
          // ignore: cast_nullable_to_non_nullable
          : lat as double,
      lng: lng == const $CopyWithPlaceholder() || lng == null
          ? _value.lng
          // ignore: cast_nullable_to_non_nullable
          : lng as double,
      speakers: speakers == const $CopyWithPlaceholder() || speakers == null
          ? _value.speakers
          // ignore: cast_nullable_to_non_nullable
          : speakers as String,
      start: start == const $CopyWithPlaceholder() || start == null
          ? _value.start
          // ignore: cast_nullable_to_non_nullable
          : start as String,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      updated: updated == const $CopyWithPlaceholder() || updated == null
          ? _value.updated
          // ignore: cast_nullable_to_non_nullable
          : updated as String,
    );
  }
}

extension $ConfEventCopyWith on ConfEvent {
  /// Returns a callable class that can be used as follows: `instanceOfclass ConfEvent implements Insertable<ConfEvent>.name.copyWith(...)` or like so:`instanceOfclass ConfEvent implements Insertable<ConfEvent>.name.copyWith.fieldName(...)`.
  _$ConfEventCWProxy get copyWith => _$ConfEventCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfEvent _$ConfEventFromJson(Map<String, dynamic> json) => ConfEvent(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
      speakers: json['speakers'] as String,
      updated: json['updated'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      day: json['day'] as int,
    );

Map<String, dynamic> _$ConfEventToJson(ConfEvent instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'start': instance.start,
      'end': instance.end,
      'speakers': instance.speakers,
      'updated': instance.updated,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'day': instance.day,
    };
