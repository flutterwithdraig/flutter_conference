part of 'home_page_cubit.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageFailed extends HomePageState {
  final String message;

  const HomePageFailed(this.message);
  @override
  List<Object> get props => [message];
}

class HomePageLoaded extends HomePageState {
  final List<ConfEvent> events;
  const HomePageLoaded({
    required this.events,
  });

  @override
  List<Object> get props => [events];
}
