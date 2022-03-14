import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/repositories/conference.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final ConferenceRepository _repo;
  HomePageCubit(ConferenceRepository repo)
      : _repo = repo,
        super(HomePageInitial()) {
    _loadEvents();
  }

  _loadEvents() async {
    List<ConfEvent> events = await _repo.getEvents();
    emit(HomePageLoaded(events: events));
  }
}
