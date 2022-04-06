import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:global_conference/repositories/authentication.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthenticationRepository _authenticationRepository;

  SigninBloc(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(const SigninState()) {
    on<SigninEmailChanged>(_emailChanged);
    on<SigninPasswordChanged>(_passwordChanged);
    on<SigninFormSubmitted>(_login);
  }

  FutureOr<void> _emailChanged(
      SigninEmailChanged event, Emitter<SigninState> emit) {
    final String email = event.email;
    final bool valid = email.length > 4;
    emit(state.copyWith(email: email, emailValid: valid));
  }

  FutureOr<void> _passwordChanged(
      SigninPasswordChanged event, Emitter<SigninState> emit) {
    final String password = event.password;
    final bool valid = password.length > 8;
    emit(state.copyWith(password: password, passwordValid: valid));
  }

  Future<FutureOr<void>> _login(
      SigninFormSubmitted event, Emitter<SigninState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      await _authenticationRepository.loginWithEmailAndPassword(
          email: state.email, password: state.password);
    } on LoginWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(formStatus: FormError(e.message)));
    }
    emit(state.copyWith(formStatus: FormSuccess()));
  }
}
