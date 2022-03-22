import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/models/user_profile.dart';

abstract class IConfRepository {
  Future<ConfEvent> getEvent(String eventID);
  Future<List<ConfEvent>> getEvents();

  Future<UserProfile> getUser(String uid);
}
