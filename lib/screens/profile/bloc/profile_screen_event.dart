part of 'profile_screen_bloc.dart';

abstract class ProfileScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileScreenLoadProfile extends ProfileScreenEvent {}

class ProfileScreenSwitchEditMode extends ProfileScreenEvent {}

class ProfileScreenUploadProfileImage extends ProfileScreenEvent {
  final XFile? file;

  ProfileScreenUploadProfileImage(this.file);

  @override
  List<Object?> get props => [file];
}
