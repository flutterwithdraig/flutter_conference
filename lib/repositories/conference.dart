import 'dart:convert';

import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/repositories/conference_interface.dart';
import 'package:http/http.dart' as http;

class ConferenceRepository implements IConfRepository {
  static const String apiHost = "http://10.0.2.2:3000";

  Uri _uri(String path) {
    return (Uri.parse("$apiHost$path"));
  }

  Future<dynamic> _get(String path) async {
    final res = await http.get(_uri(path));
    return jsonDecode(res.body);
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
}
