import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/blocs/connectivity/connectivity_cubit.dart';
import 'package:global_conference/database/database.dart';
import 'package:global_conference/firebase_options.dart';
import 'package:global_conference/repositories/conference.dart';
import 'package:global_conference/screens/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(
    db: AppDatabase(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.db}) : super(key: key);
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ConferenceRepository(database: db),
        ),
        RepositoryProvider(
          create: (context) => db,
          lazy: false,
        ),
      ],
      child: BlocProvider(
        create: (context) => ConnectivityCubit(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
