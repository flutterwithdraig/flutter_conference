import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:global_conference/database/database.dart';
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
  final AppDatabase _database;

  ConferenceRepository({required AppDatabase database}) : _database = database {
    updateEvents();
  }

  updateEvents() async {
    String from = DateTime.fromMicrosecondsSinceEpoch(0).toIso8601String();
    final lastUpdated = await _database.getLastUpdated();
    if (lastUpdated != null) {
      from = lastUpdated.updated;
    }
    List<ConfEvent> events = await _getEventsFromServer(from);
    for (ConfEvent event in events) {
      _database.insertEvent(event);
    }
  }

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

  Future<List<ConfEvent>> _getEventsFromServer(String from) async {
    final resp = await _get("/events?from=$from");
    return List<ConfEvent>.from(resp.map((d) => ConfEvent.fromJson(d)));
  }

  @override
  Stream<List<ConfEvent>> getEvents() {
    return _database.watchConfEvents();
  }

  @override
  Future<UserProfile> getUser(String uid) async {
    final resp = await _get("/users/$uid");
    return UserProfile.fromJson(resp);
  }
}
