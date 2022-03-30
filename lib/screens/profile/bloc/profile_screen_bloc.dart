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

  FutureOr<void> _switchEditMode(
      ProfileScreenSwitchEditMode event, Emitter<ProfileScreenState> emit) {
    final state = this.state;
    if (state is ProfileScreenView) {
      emit(ProfileScreenEdit(state.userProfile));
    } else if (state is ProfileScreenEdit) {
      emit(ProfileScreenView(state.userProfile));
    }
  }
}
