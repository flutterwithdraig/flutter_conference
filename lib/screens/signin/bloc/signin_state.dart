part of 'signin_bloc.dart';

class SigninState extends Equatable {
  final String email;
  final String password;
  final bool emailValid;
  final bool passwordValid;
  final FormStatus formStatus;

  const SigninState({
    this.email = '',
    this.password = '',
    this.emailValid = false,
    this.passwordValid = false,
    this.formStatus = const InitialFormStatus(),
  });

  bool get formValid => emailValid && passwordValid;

  SigninState copyWith({
    String? email,
    String? password,
    bool? emailValid,
    bool? passwordValid,
    FormStatus? formStatus,
  }) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, emailValid, passwordValid, formStatus];
}

abstract class FormStatus {
  const FormStatus();
}

class InitialFormStatus extends FormStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormStatus {}

class FormSuccess extends FormStatus {}

class FormError extends FormStatus {
  final String message;
  FormError(this.message);
}
