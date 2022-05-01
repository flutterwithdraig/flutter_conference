import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/repositories/conference.dart';

part 'home_page_state.dart';
part 'home_page_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final ConferenceRepository _repo;
  StreamSubscription? _subscription;
  HomePageBloc(ConferenceRepository repo)
      : _repo = repo,
        super(HomePageInitial()) {
    on<LoadEventByDay>(_loadEvents);
    on<EventsChanged>(_eventsChanged);
  }

  FutureOr<void> _loadEvents(
      LoadEventByDay event, Emitter<HomePageState> emit) {
    int day = event.day;
    if (day == -1) {
      final now = DateTime.now();
      // final now = DateTime.utc(2023, 3, 10);
      if (now.month == 3 && now.day >= 8 && now.day <= 11) {
        day = now.day;
      } else {
        day = 0;
      }
    }

    if (day == 0) {
      _subscription = _repo.getEvents().listen((events) {
        add(EventsChanged(events: events, day: day));
      });
    } else {
      _subscription = _repo.getEventsByDay(day).listen((events) {
        add(EventsChanged(events: events, day: day));
      });
    }
  }

  FutureOr<void> _eventsChanged(
      EventsChanged event, Emitter<HomePageState> emit) {
    emit(HomePageLoaded(events: event.events, day: event.day));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
