// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conf_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfEventCWProxy {
  ConfEvent address(String address);

  ConfEvent day(int day);

  ConfEvent details(String details);

  ConfEvent end(String end);

  ConfEvent id(String id);

  ConfEvent image(String image);

  ConfEvent lat(double lat);

  ConfEvent lng(double lng);

  ConfEvent purchaseCode(String purchaseCode);

  ConfEvent speakers(String speakers);

  ConfEvent start(String start);

  ConfEvent streamedEvent(bool streamedEvent);

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
    String? details,
    String? end,
    String? id,
    String? image,
    double? lat,
    double? lng,
    String? purchaseCode,
    String? speakers,
    String? start,
    bool? streamedEvent,
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
  ConfEvent details(String details) => this(details: details);

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
  ConfEvent purchaseCode(String purchaseCode) =>
      this(purchaseCode: purchaseCode);

  @override
  ConfEvent speakers(String speakers) => this(speakers: speakers);

  @override
  ConfEvent start(String start) => this(start: start);

  @override
  ConfEvent streamedEvent(bool streamedEvent) =>
      this(streamedEvent: streamedEvent);

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
    Object? details = const $CopyWithPlaceholder(),
    Object? end = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? lat = const $CopyWithPlaceholder(),
    Object? lng = const $CopyWithPlaceholder(),
    Object? purchaseCode = const $CopyWithPlaceholder(),
    Object? speakers = const $CopyWithPlaceholder(),
    Object? start = const $CopyWithPlaceholder(),
    Object? streamedEvent = const $CopyWithPlaceholder(),
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
      details: details == const $CopyWithPlaceholder() || details == null
          ? _value.details
          // ignore: cast_nullable_to_non_nullable
          : details as String,
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
      purchaseCode:
          purchaseCode == const $CopyWithPlaceholder() || purchaseCode == null
              ? _value.purchaseCode
              // ignore: cast_nullable_to_non_nullable
              : purchaseCode as String,
      speakers: speakers == const $CopyWithPlaceholder() || speakers == null
          ? _value.speakers
          // ignore: cast_nullable_to_non_nullable
          : speakers as String,
      start: start == const $CopyWithPlaceholder() || start == null
          ? _value.start
          // ignore: cast_nullable_to_non_nullable
          : start as String,
      streamedEvent:
          streamedEvent == const $CopyWithPlaceholder() || streamedEvent == null
              ? _value.streamedEvent
              // ignore: cast_nullable_to_non_nullable
              : streamedEvent as bool,
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
      details: json['details'] as String,
      purchaseCode: json['purchaseCode'] as String? ?? '',
      streamedEvent: json['streamedEvent'] as bool? ?? false,
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
      'details': instance.details,
      'purchaseCode': instance.purchaseCode,
      'streamedEvent': instance.streamedEvent,
    };
