import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/const.dart';
import 'package:global_conference/screens/home/cubit/home_page_cubit.dart';
import 'package:global_conference/screens/home/widgets/date_row.dart';

import 'widgets/agenda.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(context.read()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Global Conf'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              DateRow(),
              SizedBox(height: 24),
              Text('Agenda', style: AppFonts.headline1),
              SizedBox(height: 12),
              Agenda()
            ],
          ),
        ),
      ),
    );
  }
}
