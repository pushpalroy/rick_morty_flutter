import 'package:json_annotation/json_annotation.dart';

part 'dt_location.g.dart';

@JsonSerializable()
class DTLocation {
  DTLocation(this.id, this.name, this.type, this.dimension, this.created);

  String id, name, type, dimension, created;

  factory DTLocation.fromJson(Map<String, dynamic> json) =>
      _$DTLocationFromJson(json);

  Map<String, dynamic> toJson() => _$DTLocationToJson(this);
}
