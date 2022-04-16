import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:global_conference/models/user_profile.dart';
import 'package:global_conference/repositories/conference.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_screen_state.dart';
part 'profile_screen_event.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  final ConferenceRepository _repository;

  ProfileScreenBloc(ConferenceRepository repository)
      : _repository = repository,
        super(ProfileScreenInitial()) {
    on<ProfileScreenLoadProfile>(_loadProfile);
    on<ProfileScreenUploadProfileImage>(_uploadProfileImage);
    on<ProfileScreenSwitchEditMode>(_switchEditMode);
    on<EditProfileName>(_editProfileName);
    on<EditProfileProfile>(_editProfileProfile);
  }

  FutureOr<void> _loadProfile(
      ProfileScreenLoadProfile event, Emitter<ProfileScreenState> emit) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    UserProfile profile = await _repository.getUser(uid);
    emit(ProfileScreenView(profile));
  }

  FutureOr<void> _uploadProfileImage(ProfileScreenUploadProfileImage event,
      Emitter<ProfileScreenState> emit) async {
    if (event.file == null) return;
    final state = this.state as ProfileScreenLoaded;
    final url = await _repository.uploadProfileImage(
        state.userProfile.uid, event.file!);
    UserProfile profile = state.userProfile.copyWith(imageUrl: url);
    emit(ProfileScreenView(profile));
  }

  Future<FutureOr<void>> _switchEditMode(ProfileScreenSwitchEditMode event,
      Emitter<ProfileScreenState> emit) async {
    final state = this.state;
    if (state is ProfileScreenView) {
      emit(ProfileScreenEdit(userProfile: state.userProfile));
    } else if (state is ProfileScreenEdit) {
      if (state.nameValid && state.profileValid) {
        if (state.name != state.userProfile.name ||
            state.profile != state.userProfile.profile) {
          UserProfile newProfile = state.userProfile.copyWith(
            name: state.name,
            profile: state.profile,
          );

          emit(ProfileScreenView(newProfile));
          var res = await _repository.saveUserProfile(newProfile);
          if (res != 200) {
            emit(ProfileScreenView(state.userProfile));
          }
        } else {
          emit(ProfileScreenView(state.userProfile));
        }
      }
    }
  }

  FutureOr<void> _editProfileName(
      EditProfileName event, Emitter<ProfileScreenState> emit) {
    if (event.text.length < 5) {
      emit((state as ProfileScreenEdit)
          .copyWith(name: event.text, nameValid: false));
    } else {
      emit((state as ProfileScreenEdit)
          .copyWith(name: event.text, nameValid: true));
    }
  }

  FutureOr<void> _editProfileProfile(
      EditProfileProfile event, Emitter<ProfileScreenState> emit) {
    emit((state as ProfileScreenEdit)
        .copyWith(profile: event.text, profileValid: true));
  }
}
