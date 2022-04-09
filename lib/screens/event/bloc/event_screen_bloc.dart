import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:global_conference/database/database.dart';
import 'package:global_conference/models/conf_event.dart';

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

  FutureOr<void> _switchPage(SwitchPage event, Emitter<EventScreenState> emit) {
    switch (event.type) {
      case EventPageType.details:
        emit((state as EventScreenLoaded)
            .copyWith(page: const EventPageDetails()));
        break;
      case EventPageType.map:
        emit((state as EventScreenLoaded).copyWith(page: EventPageMap()));
        break;
    }
  }
}
