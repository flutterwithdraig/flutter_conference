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
  const ProfileScreenEdit(UserProfile userProfile) : super(userProfile);
}
