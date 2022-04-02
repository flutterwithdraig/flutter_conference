import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/repositories/authentication.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<AuthenticationRepository>().loginWithEmailAndPassword(
                email: 'draig@test.com', password: 'password123');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
