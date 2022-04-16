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

class EditProfileName extends ProfileScreenEvent {
  final String text;
  EditProfileName(this.text);
  @override
  List<Object?> get props => [text];
}

class EditProfileProfile extends ProfileScreenEvent {
  final String text;
  EditProfileProfile(this.text);
  @override
  List<Object?> get props => [text];
}

class SaveProfile extends ProfileScreenEvent {}
