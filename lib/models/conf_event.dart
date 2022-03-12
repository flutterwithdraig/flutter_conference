import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conf_event.g.dart';

@CopyWith()
@JsonSerializable()
class ConfEvent {
  String id;
  String title;
  ConfEvent({
    required this.id,
    required this.title,
  });

  static ConfEvent fromJson(Map<String, dynamic> json) =>
      _$ConfEventFromJson(json);
}
