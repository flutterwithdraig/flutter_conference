import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@CopyWith()
@JsonSerializable()
class UserProfile {
  final String uid;
  final String name;
  final String profile;
  final String? imageUrl;

  UserProfile(
      {required this.uid,
      required this.name,
      required this.profile,
      this.imageUrl});

  static UserProfile fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
