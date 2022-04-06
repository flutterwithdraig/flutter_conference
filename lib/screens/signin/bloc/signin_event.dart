part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class SigninEmailChanged extends SigninEvent {
  final String email;
  const SigninEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class SigninPasswordChanged extends SigninEvent {
  final String password;
  const SigninPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class SigninFormSubmitted extends SigninEvent {}
