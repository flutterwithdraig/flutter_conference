import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/event_screen_bloc.dart';
import 'widgets/index.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) =>
          EventScreenBloc(context.read())..add(LoadEvent(eventId)),
      child: Scaffold(
        bottomNavigationBar: Builder(builder: (context) {
          return BottomNavigationBar(
            onTap: (index) {
              switch (index) {
                case 0:
                  context
                      .read<EventScreenBloc>()
                      .add(const SwitchPage(EventPageType.details));
                  break;
                case 1:
                  context
                      .read<EventScreenBloc>()
                      .add(const SwitchPage(EventPageType.map));
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.subject), label: 'Event Details'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.room), label: 'Event Location'),
            ],
          );
        }),
        body: BlocBuilder<EventScreenBloc, EventScreenState>(
          builder: (context, state) {
            if (state is EventScreenLoading) {
              return const CircularProgressIndicator();
            } else if (state is EventScreenLoaded) {
              if (state.page is EventPageDetails) {
                return EventDetails(event: state.event);
              } else if (state.page is EventPageMap) {
                return const EventMap();
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
