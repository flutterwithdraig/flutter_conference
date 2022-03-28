import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/blocs/connectivity/connectivity_cubit.dart';

class NetworkInfo extends StatelessWidget {
  const NetworkInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityInitial || state is ConnectivityConnected) {
          return const SizedBox();
        } else {
          return const SizedBox(
            child: Text("No network connection"),
          );
        }
      },
    );
  }
}
