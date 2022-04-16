part of 'profile_screen_bloc.dart';

abstract class ProfileScreenState extends Equatable {
  const ProfileScreenState();

  @override
  List<Object> get props => [];
}

class ProfileScreenInitial extends ProfileScreenState {}

abstract class ProfileScreenLoaded extends ProfileScreenState {
  final UserProfile userProfile;

  const ProfileScreenLoaded(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class ProfileScreenView extends ProfileScreenLoaded {
  const ProfileScreenView(UserProfile userProfile) : super(userProfile);
}

class ProfileScreenEdit extends ProfileScreenLoaded {
  final String name;
  final String profile;
  final bool nameValid;
  final bool profileValid;

  ProfileScreenEdit({
    required UserProfile userProfile,
    this.nameValid = true,
    this.profileValid = true,
  })  : name = userProfile.name,
        profile = userProfile.profile,
        super(userProfile);

  const ProfileScreenEdit.fromProfileScreen({
    required UserProfile userProfile,
    this.name = '',
    this.profile = '',
    this.nameValid = true,
    this.profileValid = true,
  }) : super(userProfile);

  ProfileScreenEdit copyWith({
    String? name,
    String? profile,
    bool? nameValid,
    bool? profileValid,
  }) {
    return ProfileScreenEdit.fromProfileScreen(
      userProfile: userProfile,
      name: name ?? this.name,
      profile: profile ?? this.profile,
      nameValid: nameValid ?? this.nameValid,
      profileValid: profileValid ?? this.profileValid,
    );
  }

  @override
  List<Object> get props => [name, profile, nameValid, profileValid];
}
