part of 'event_screen_bloc.dart';

abstract class EventScreenEvent extends Equatable {
  const EventScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends EventScreenEvent {
  final String eventId;

  const LoadEvent(this.eventId);

  @override
  List<Object> get props => [eventId];
}

class SwitchPage extends EventScreenEvent {
  final EventPageType type;

  const SwitchPage(this.type);
  @override
  List<Object> get props => [type];
}
