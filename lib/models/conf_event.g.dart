// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conf_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfEventCWProxy {
  ConfEvent id(String id);

  ConfEvent title(String title);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfEvent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfEvent(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfEvent call({
    String? id,
    String? title,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfEvent.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfEvent.copyWith.fieldName(...)`
class _$ConfEventCWProxyImpl implements _$ConfEventCWProxy {
  final ConfEvent _value;

  const _$ConfEventCWProxyImpl(this._value);

  @override
  ConfEvent id(String id) => this(id: id);

  @override
  ConfEvent title(String title) => this(title: title);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfEvent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfEvent(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfEvent call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
  }) {
    return ConfEvent(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
    );
  }
}

extension $ConfEventCopyWith on ConfEvent {
  /// Returns a callable class that can be used as follows: `instanceOfclass ConfEvent.name.copyWith(...)` or like so:`instanceOfclass ConfEvent.name.copyWith.fieldName(...)`.
  _$ConfEventCWProxy get copyWith => _$ConfEventCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfEvent _$ConfEventFromJson(Map<String, dynamic> json) => ConfEvent(
      id: json['id'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$ConfEventToJson(ConfEvent instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
