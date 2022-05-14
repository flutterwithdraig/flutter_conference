import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/screens/event/bloc/event_screen_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
