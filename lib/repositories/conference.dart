import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/models/user_profile.dart';
import 'package:global_conference/repositories/conference_interface.dart';
import 'package:http/http.dart' as http;

class RepoFailure implements Exception {
  RepoFailure(this.message);
  String message = '';
}

class ConferenceRepository implements IConfRepository {
  static const String apiHost = "http://10.0.2.2:3000";

  Uri _uri(String path) {
    return (Uri.parse("$apiHost$path"));
  }

  Future<dynamic> _get(String path) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final res =
        await http.get(_uri(path), headers: {"Authorization": "Token $token"});

    switch (res.statusCode) {
      case 401:
        throw RepoFailure('Auth Failed');
      default:
        return jsonDecode(res.body);
    }
  }

  @override
  Future<ConfEvent> getEvent(String eventID) async {
    final resp = await _get("/events/$eventID");
    return ConfEvent.fromJson(resp);
  }

  @override
  Future<List<ConfEvent>> getEvents() async {
    final resp = await _get("/events");
    return List<ConfEvent>.from(resp.map((d) => ConfEvent.fromJson(d)));
  }

  @override
  Future<UserProfile> getUser(String uid) async {
    final resp = await _get("/users/$uid");
    return UserProfile.fromJson(resp);
  }
}
