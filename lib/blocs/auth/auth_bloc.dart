import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:global_conference/models/app_user.dart';
import 'package:global_conference/repositories/authentication.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AuthState.authenticated(authenticationRepository.currentUser)
            : const AuthState.unauthenticated()) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthRequestLogout>(_logout);

    _userSubscription = _authenticationRepository.user.listen((user) {
      add(AuthUserChanged(user));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AppUser> _userSubscription;

  FutureOr<void> _onUserChanged(
      AuthUserChanged event, Emitter<AuthState> emit) {
    emit(event.user.isEmpty
        ? const AuthState.unauthenticated()
        : AuthState.authenticated(event.user));
  }

  FutureOr<void> _logout(AuthRequestLogout event, Emitter<AuthState> emit) {
    unawaited(_authenticationRepository.logout());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
