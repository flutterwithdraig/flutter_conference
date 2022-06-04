part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUserChanged extends AuthEvent {
  const AuthUserChanged(this.user);

  final AppUser user;

  @override
  List<Object> get props => [user];
}

class AuthRequestLogout extends AuthEvent {}

class AuthAddPaidEvent extends AuthEvent {
  final String eventCode;
  const AuthAddPaidEvent(this.eventCode);
  @override
  List<Object> get props => [eventCode];
}
