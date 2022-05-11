import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/const.dart';
import 'package:global_conference/screens/home/bloc/home_page_bloc.dart';
import 'package:global_conference/screens/home/widgets/date_row.dart';
import 'package:global_conference/screens/profile/profile.dart';
import 'package:global_conference/widgets/cart/cart_button.dart';
import 'package:global_conference/widgets/network_info.dart';

import 'widgets/agenda.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomePageBloc(context.read())..add(const LoadEventByDay(day: -1)),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Global Conf'),
          actions: [
            const CartButton(),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
            )
          ],
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
              NetworkInfo(),
              Agenda()
            ],
          ),
        ),
      ),
    );
  }
}
