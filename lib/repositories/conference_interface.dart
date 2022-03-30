import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/models/user_profile.dart';
import 'package:image_picker/image_picker.dart';

abstract class IConfRepository {
  Future<ConfEvent> getEvent(String eventID);
  Stream<List<ConfEvent>> getEvents();

  Future<UserProfile> getUser(String uid);
  Future<String> uploadProfileImage(String uid, XFile file);
}
