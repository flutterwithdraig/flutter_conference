import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:global_conference/blocs/auth/auth_bloc.dart';
import 'package:global_conference/blocs/cart/cart_bloc.dart';
import 'package:global_conference/blocs/connectivity/connectivity_cubit.dart';
import 'package:global_conference/database/database.dart';
import 'package:global_conference/firebase_options.dart';
import 'package:global_conference/repositories/authentication.dart';
import 'package:global_conference/repositories/conference.dart';
import 'package:global_conference/screens/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51Kqg4QBMUshhE7NfBNXDMOGfbvZV1N0LCWQle1rW3a74DPZfh96V3e524h3BZzXJEg3qJlE5Ch75cU6To0itAvfc00m0Td7IhE';
  await Stripe.instance.applySettings();

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
    final ConferenceRepository conferenceRepository =
        ConferenceRepository(database: db);

    final AuthBloc authBloc = AuthBloc(
        authenticationRepository: authenticationRepository,
        conferenceRepository: conferenceRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider(
          create: (context) => conferenceRepository,
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
            create: (context) => authBloc,
          ),
          BlocProvider(
            create: (context) => CartBloc(
              conferenceRepository: context.read<ConferenceRepository>(),
              authBloc: authBloc,
            ),
          ),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous.status != current.status,
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
              '/login': (context) => SignInScreen(),
              '/home': (context) => const HomeScreen(),
              '/event': (context) => const EventScreen(),
              '/checkout': (context) => const CheckoutScreen(),
              '/livecast': (context) => const LiveCastScreen(),
            },
            initialRoute: '/',
          ),
        ),
      ),
    );
  }
}
