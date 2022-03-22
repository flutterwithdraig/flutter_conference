// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserProfileCWProxy {
  UserProfile name(String name);

  UserProfile profile(String profile);

  UserProfile uid(String uid);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserProfile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserProfile(...).copyWith(id: 12, name: "My name")
  /// ````
  UserProfile call({
    String? name,
    String? profile,
    String? uid,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserProfile.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserProfile.copyWith.fieldName(...)`
class _$UserProfileCWProxyImpl implements _$UserProfileCWProxy {
  final UserProfile _value;

  const _$UserProfileCWProxyImpl(this._value);

  @override
  UserProfile name(String name) => this(name: name);

  @override
  UserProfile profile(String profile) => this(profile: profile);

  @override
  UserProfile uid(String uid) => this(uid: uid);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserProfile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserProfile(...).copyWith(id: 12, name: "My name")
  /// ````
  UserProfile call({
    Object? name = const $CopyWithPlaceholder(),
    Object? profile = const $CopyWithPlaceholder(),
    Object? uid = const $CopyWithPlaceholder(),
  }) {
    return UserProfile(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      profile: profile == const $CopyWithPlaceholder() || profile == null
          ? _value.profile
          // ignore: cast_nullable_to_non_nullable
          : profile as String,
      uid: uid == const $CopyWithPlaceholder() || uid == null
          ? _value.uid
          // ignore: cast_nullable_to_non_nullable
          : uid as String,
    );
  }
}

extension $UserProfileCopyWith on UserProfile {
  /// Returns a callable class that can be used as follows: `instanceOfclass UserProfile.name.copyWith(...)` or like so:`instanceOfclass UserProfile.name.copyWith.fieldName(...)`.
  _$UserProfileCWProxy get copyWith => _$UserProfileCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      uid: json['uid'] as String,
      name: json['name'] as String,
      profile: json['profile'] as String,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'profile': instance.profile,
    };
