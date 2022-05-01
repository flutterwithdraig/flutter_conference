part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
  @override
  List<Object?> get props => [];
}

class LoadEventByDay extends HomePageEvent {
  final int day;
  const LoadEventByDay({
    this.day = -1,
  });
  @override
  List<Object?> get props => [day];
}

class EventsChanged extends HomePageEvent {
  final List<ConfEvent> events;
  final int day;
  const EventsChanged({
    required this.events,
    required this.day,
  });
  @override
  List<Object?> get props => [events, day];
}
