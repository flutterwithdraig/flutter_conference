import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:global_conference/database/database.dart';
import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/models/user_profile.dart';
import 'package:global_conference/repositories/conference_interface.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RepoFailure implements Exception {
  RepoFailure(this.message);
  String message = '';
}

class ConferenceRepository implements IConfRepository {
  // static const String apiHost = "http://10.0.2.2:3000";
  static const String apiHost = "https://global-conference.ew.r.appspot.com";
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

  Future<dynamic> _patch(String path, Map<String, String> body) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final res = await http.patch(
      _uri(path),
      headers: {
        "Authorization": "Token $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(body),
    );

    switch (res.statusCode) {
      case 401:
        throw RepoFailure('Auth Failed');
      default:
        return jsonDecode(res.body);
    }
  }

  Future<dynamic> _post(String path, Map<String, String> body) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final res = await http.post(
      _uri(path),
      headers: {
        "Authorization": "Token $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(body),
    );

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
  Stream<List<ConfEvent>> getEventsByDay(int day) {
    return _database.watchConfEventsByDay(day);
  }

  @override
  Future<UserProfile> getUser(String uid) async {
    final resp = await _get("/users/$uid");
    return UserProfile.fromJson(resp);
  }

  @override
  Future<String> uploadProfileImage(String uid, XFile file) async {
    var request = http.MultipartRequest("POST", _uri("/users/$uid/image"));

    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    request.headers['Authorization'] = "Token $token";
    final bytes = await file.readAsBytes();
    final image = http.MultipartFile.fromBytes('image', bytes);
    request.files.add(image);

    var resp = await request.send();
    var respData = await resp.stream.toBytes();
    var result = String.fromCharCodes(respData);
    if (resp.statusCode == 200) {
      var json = jsonDecode(result);
      return json['imageUrl'];
    }

    return '';
  }

  @override
  Future<int> saveUserProfile(UserProfile userProfile) async {
    var resp = await _patch(
      "/users/${userProfile.uid}",
      {
        "name": userProfile.name,
        "profile": userProfile.profile,
      },
    );
    return resp['code'];
  }

  @override
  Future<Map<String, dynamic>> createPaymentSheet(String cart) async {
    final response = await _post('/stripe/payment-sheet', {'cart': cart});
    return response;
  }

  @override
  Future<List<String>> getPaidEvents(String uid) async {
    final resp = await _get("/users/$uid/paidevents");
    return List<String>.from(resp['events']);
  }

  @override
  Future<String> getLiveToken(String uid, String eventId) async {
    final resp = await _get("/users/$uid/livetoken/$eventId");
    return resp['token'] as String;
  }
}
