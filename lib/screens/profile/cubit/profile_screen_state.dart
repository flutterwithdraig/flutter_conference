part of 'profile_screen_cubit.dart';

abstract class ProfileScreenState extends Equatable {
  const ProfileScreenState();

  @override
  List<Object> get props => [];
}

class ProfileScreenInitial extends ProfileScreenState {}

class ProfileScreenLoaded extends ProfileScreenState {
  final UserProfile userProfile;

  const ProfileScreenLoaded(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}
