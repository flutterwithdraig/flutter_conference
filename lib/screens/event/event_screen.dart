import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/const.dart';
import 'package:global_conference/widgets/cart/add_item_button.dart';
import 'package:global_conference/widgets/cart/cart_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'bloc/event_screen_bloc.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) =>
          EventScreenBloc(context.read())..add(LoadEvent(eventId)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: BlocBuilder<EventScreenBloc, EventScreenState>(
            builder: (context, state) {
              return AppBar(
                title:
                    state is EventScreenLoaded ? Text(state.event.title) : null,
                actions: const [
                  CartButton(),
                  SizedBox(
                    width: 16,
                  )
                ],
              );
            },
          ),
        ),
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
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Event Screen $eventId'),
                      AddItemToCartButton(cartItem: AppProducts.event1),
                    ],
                  ),
                );
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

class EventMap extends StatelessWidget {
  const EventMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventScreenBloc, EventScreenState>(
      builder: (context, stateIn) {
        final state = stateIn as EventScreenLoaded;
        final latLng = LatLng(state.event.lat, state.event.lng);
        final eventLocation = CameraPosition(target: latLng, zoom: 16);
        final marker = (state.page as EventPageMap).marker;

        return GoogleMap(
          initialCameraPosition: eventLocation,
          markers: {marker},
        );
      },
    );
  }
}
