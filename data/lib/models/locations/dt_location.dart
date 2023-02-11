import 'package:json_annotation/json_annotation.dart';

part 'dt_location.g.dart';

@JsonSerializable()
class DTLocation {
  DTLocation(this.id, this.name, this.type, this.dimension, this.created);

  factory DTLocation.fromJson(Map<String, dynamic> json) =>
      _$DTLocationFromJson(json);

  String id, name, type, dimension, created;

  Map<String, dynamic> toJson() => _$DTLocationToJson(this);
}
