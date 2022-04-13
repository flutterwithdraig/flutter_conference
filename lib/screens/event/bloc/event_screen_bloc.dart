import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:global_conference/const.dart';
import 'package:global_conference/database/database.dart';
import 'package:global_conference/models/conf_event.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'event_screen_event.dart';
part 'event_screen_state.dart';

class EventScreenBloc extends Bloc<EventScreenEvent, EventScreenState> {
  final AppDatabase _db;

  EventScreenBloc(AppDatabase db)
      : _db = db,
        super(EventScreenLoading()) {
    on<LoadEvent>(_loadEvent);
    on<SwitchPage>(_switchPage);
  }

  FutureOr<void> _loadEvent(
      LoadEvent event, Emitter<EventScreenState> emit) async {
    final confEvent = await (_db.select(_db.confEvents)
          ..where((tbl) => tbl.id.equals(event.eventId)))
        .getSingle();

    emit(EventScreenLoaded(event: confEvent));
  }

  FutureOr<void> _switchPage(
      SwitchPage event, Emitter<EventScreenState> emit) async {
    switch (event.type) {
      case EventPageType.details:
        emit((state as EventScreenLoaded)
            .copyWith(page: const EventPageDetails()));
        break;
      case EventPageType.map:
        final marker = await _buildMarker(state as EventScreenLoaded);

        emit((state as EventScreenLoaded)
            .copyWith(page: EventPageMap(marker: marker)));
        break;
    }
  }

  Future<Marker> _buildMarker(EventScreenLoaded state) async {
    final event = state.event;

    final Uint8List markerIcon = await _buildMarkerIcon(event);

    return Marker(
        markerId: MarkerId(event.id),
        position: LatLng(event.lat, event.lng),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        anchor: const Offset(0.5, 0),
        infoWindow: InfoWindow(
          title: event.title,
          snippet: event.address,
        ));
  }

  Future<Uint8List> _buildMarkerIcon(ConfEvent event) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = AppColors.primary;

    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: event.title,
      style: AppFonts.headline1.copyWith(color: AppColors.orange),
    );

    painter.layout();
    final height = painter.height.toInt() + 30;
    final width = painter.width.toInt() + 30;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            20,
            width.toDouble(),
            height.toDouble(),
          ),
          const Radius.circular(20),
        ),
        paint);

    Path path = Path();
    double hw = width * 0.5;
    path.moveTo(hw - 20, 20);
    path.lineTo(hw, 0);
    path.lineTo(hw + 20, 20);
    canvas.drawPath(path, paint);

    painter.paint(
      canvas,
      Offset(
        (width * 0.5) - painter.width * 0.5,
        ((height * 0.5) - painter.height * 0.5 + 20),
      ),
    );
    final img =
        await pictureRecorder.endRecording().toImage(width, height + 20);
    final data = await img.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
}
