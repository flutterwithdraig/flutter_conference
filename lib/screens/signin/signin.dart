import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/const.dart';
import 'package:global_conference/repositories/authentication.dart';

import 'bloc/signin_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninBloc(context.read<AuthenticationRepository>()),
      child: Scaffold(body: LayoutBuilder(
        builder: (context, constraints) {
          bool shrink = constraints.maxHeight < 500;
          return Stack(
            children: [_background(), _title(shrink), _form(shrink)],
          );
        },
      )),
    );
  }

  Widget _form(bool shrink) {
    return BlocListener<SigninBloc, SigninState>(
      listenWhen: (previous, current) =>
          previous.formStatus != current.formStatus &&
          current.formStatus is FormError,
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is FormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(formStatus.message),
            ),
          );
        }
      },
      child: Positioned(
        bottom: shrink ? 10 : 100,
        left: 20,
        right: 20,
        child: BlurBackground(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(200),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _emailField(),
                  _passwordField(),
                  _loginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: AppColors.primary,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SigninBloc>().add(SigninFormSubmitted());
                  }
                },
                child: const Text('Sign in'),
              );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<SigninBloc, SigninState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) =>
              context.read<SigninBloc>().add(SigninEmailChanged(value)),
          validator: (value) => state.emailValid ? null : 'Check email address',
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              label: Text(
                'Email',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              iconColor: Colors.white,
              hintText: 'Email address you registered with',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              hintStyle: TextStyle(color: Colors.white)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SigninBloc, SigninState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) =>
              context.read<SigninBloc>().add(SigninPasswordChanged(value)),
          validator: (value) => state.passwordValid ? null : 'Check password',
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          decoration: const InputDecoration(
              label: Text(
                'Password',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              iconColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
              hintStyle: TextStyle(color: Colors.white)),
        );
      },
    );
  }

  Positioned _title(bool shrink) {
    return Positioned(
      top: shrink ? 50 : 100,
      left: 50,
      right: 50,
      child: BlurBackground(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white.withAlpha(200),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              const Text(
                'Global Con',
                style: AppFonts.headline1,
              ),
              if (!shrink) ...[
                Text(
                  '2023',
                  style: AppFonts.headline1.copyWith(
                    color: AppColors.orange,
                  ),
                ),
                const Text(
                  'Participants Guide',
                  style: AppFonts.subtitle,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Container _background() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/signinbackground.jpg'),
        ),
      ),
    );
  }
}

class BlurBackground extends StatelessWidget {
  const BlurBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: child,
      ),
    );
  }
}
