import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/screens/livecast/cubit/livecast_cubit.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemote;

class LiveCastScreen extends StatelessWidget {
  const LiveCastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as ConfEvent;

    return BlocProvider(
      create: (context) => LivecastCubit(
        authBloc: context.read(),
        conferenceRepository: context.read(),
        confEvent: event,
      ),
      lazy: false,
      child: Scaffold(
        body: BlocBuilder<LivecastCubit, LivecastState>(
          builder: (context, state) {
            return (state is LivecastLoaded)
                ? RtcRemote.SurfaceView(
                    channelId: event.id,
                    uid: state.uid,
                  )
                : const Center(
                    child: Text('Livecast'),
                  );
          },
        ),
      ),
    );
  }
}
