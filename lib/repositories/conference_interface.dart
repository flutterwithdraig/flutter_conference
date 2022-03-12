import 'package:global_conference/models/conf_event.dart';

abstract class IConfRepository {
  Future<ConfEvent> getEvent(String eventID);
  Future<List<ConfEvent>> getEvents();
}
