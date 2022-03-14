import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conf_event.g.dart';

@CopyWith()
@JsonSerializable()
class ConfEvent {
  String id;
  String title;
  String image;
  String start;
  String end;
  String speakers;

  ConfEvent({
    required this.id,
    required this.title,
    required this.image,
    required this.start,
    required this.end,
    required this.speakers,
  });

  static ConfEvent fromJson(Map<String, dynamic> json) =>
      _$ConfEventFromJson(json);
}
