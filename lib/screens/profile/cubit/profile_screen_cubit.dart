import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:global_conference/models/user_profile.dart';
import 'package:global_conference/repositories/conference.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  final ConferenceRepository _repository;

  ProfileScreenCubit(ConferenceRepository repository)
      : _repository = repository,
        super(ProfileScreenInitial()) {
    _loadProfile();
  }

  _loadProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    UserProfile profile = await _repository.getUser(uid);
    emit(ProfileScreenLoaded(profile));
  }
}
