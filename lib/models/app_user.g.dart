// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AppUserCWProxy {
  AppUser email(String? email);

  AppUser paidEvents(List<String> paidEvents);

  AppUser uid(String uid);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppUser(...).copyWith(id: 12, name: "My name")
  /// ````
  AppUser call({
    String? email,
    List<String>? paidEvents,
    String? uid,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAppUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAppUser.copyWith.fieldName(...)`
class _$AppUserCWProxyImpl implements _$AppUserCWProxy {
  final AppUser _value;

  const _$AppUserCWProxyImpl(this._value);

  @override
  AppUser email(String? email) => this(email: email);

  @override
  AppUser paidEvents(List<String> paidEvents) => this(paidEvents: paidEvents);

  @override
  AppUser uid(String uid) => this(uid: uid);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppUser(...).copyWith(id: 12, name: "My name")
  /// ````
  AppUser call({
    Object? email = const $CopyWithPlaceholder(),
    Object? paidEvents = const $CopyWithPlaceholder(),
    Object? uid = const $CopyWithPlaceholder(),
  }) {
    return AppUser(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      paidEvents:
          paidEvents == const $CopyWithPlaceholder() || paidEvents == null
              ? _value.paidEvents
              // ignore: cast_nullable_to_non_nullable
              : paidEvents as List<String>,
      uid: uid == const $CopyWithPlaceholder() || uid == null
          ? _value.uid
          // ignore: cast_nullable_to_non_nullable
          : uid as String,
    );
  }
}

extension $AppUserCopyWith on AppUser {
  /// Returns a callable class that can be used as follows: `instanceOfclass AppUser extends Equatable.name.copyWith(...)` or like so:`instanceOfclass AppUser extends Equatable.name.copyWith.fieldName(...)`.
  _$AppUserCWProxy get copyWith => _$AppUserCWProxyImpl(this);
}
