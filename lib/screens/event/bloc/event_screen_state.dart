part of 'event_screen_bloc.dart';

abstract class EventScreenState extends Equatable {
  const EventScreenState();

  @override
  List<Object> get props => [];
}

class EventScreenLoading extends EventScreenState {}

class EventScreenLoaded extends EventScreenState {
  final ConfEvent event;
  final EventPage page;

  const EventScreenLoaded({
    required this.event,
    this.page = const EventPageDetails(),
  });

  EventScreenLoaded copyWith({
    ConfEvent? event,
    EventPage? page,
  }) {
    return EventScreenLoaded(
      event: event ?? this.event,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [event, page];
}

enum EventPageType { details, map }

abstract class EventPage extends Equatable {
  const EventPage();
  @override
  List<Object?> get props => [];
}

class EventPageDetails extends EventPage {
  const EventPageDetails();
}

class EventPageMap extends EventPage {}
