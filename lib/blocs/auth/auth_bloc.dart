import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:global_conference/models/app_user.dart';
import 'package:global_conference/repositories/authentication.dart';
import 'package:global_conference/repositories/conference.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthenticationRepository authenticationRepository,
    required ConferenceRepository conferenceRepository,
  })  : _authenticationRepository = authenticationRepository,
        _conferenceRepository = conferenceRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AuthState.authenticated(authenticationRepository.currentUser)
            : const AuthState.unauthenticated()) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthRequestLogout>(_logout);
    on<AuthAddPaidEvent>(_addPaidEvent);

    _userSubscription = _authenticationRepository.user.listen((user) {
      add(AuthUserChanged(user));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  final ConferenceRepository _conferenceRepository;
  late final StreamSubscription<AppUser> _userSubscription;

  FutureOr<void> _onUserChanged(
      AuthUserChanged event, Emitter<AuthState> emit) async {
    if (event.user.isEmpty) {
      emit(const AuthState.unauthenticated());
    } else {
      final events = await _conferenceRepository.getPaidEvents(event.user.uid);
      emit(AuthState.authenticated(event.user.copyWith(paidEvents: events)));
    }
  }

  FutureOr<void> _logout(AuthRequestLogout event, Emitter<AuthState> emit) {
    unawaited(_authenticationRepository.logout());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _addPaidEvent(
      AuthAddPaidEvent event, Emitter<AuthState> emit) {
    List<String> events = List.from(state.user.paidEvents);
    events.add(event.eventCode);
    emit(AuthState.authenticated(state.user.copyWith(paidEvents: events)));
  }
}
