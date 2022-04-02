import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/blocs/auth/auth_bloc.dart';
import 'package:global_conference/blocs/connectivity/connectivity_cubit.dart';
import 'package:global_conference/database/database.dart';
import 'package:global_conference/firebase_options.dart';
import 'package:global_conference/repositories/authentication.dart';
import 'package:global_conference/repositories/conference.dart';
import 'package:global_conference/screens/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(
    db: AppDatabase(),
    authenticationRepository: AuthenticationRepository(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.db,
    required this.authenticationRepository,
  }) : super(key: key);
  final AppDatabase db;
  final AuthenticationRepository authenticationRepository;
  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider(
          create: (context) => ConferenceRepository(database: db),
        ),
        RepositoryProvider(
          create: (context) => db,
          lazy: false,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ConnectivityCubit(),
          ),
          BlocProvider(
            create: (context) =>
                AuthBloc(authenticationRepository: authenticationRepository),
          ),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              _navKey.currentState!.pushReplacementNamed('/home');
            } else {
              _navKey.currentState!.pushReplacementNamed('/login');
            }
          },
          child: MaterialApp(
            navigatorKey: _navKey,
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => const SignInScreen(),
              '/home': (context) => const HomeScreen(),
            },
            initialRoute: '/',
          ),
        ),
      ),
    );
  }
}
