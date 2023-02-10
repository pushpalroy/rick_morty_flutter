import 'package:json_annotation/json_annotation.dart';

part 'dt_character_info.g.dart';

@JsonSerializable()
class DTCharacterInfo {
  DTCharacterInfo(this.id, this.name, this.image, this.status, this.species,
      this.gender, this.origin, this.location);

  final String? id, name, image, status, species, gender;
  final DTOrigin? origin;
  final DTLocation? location;

  factory DTCharacterInfo.fromJson(Map<String, dynamic> json) =>
      _$DTCharacterInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DTCharacterInfoToJson(this);
}

@JsonSerializable()
class DTOrigin {
  DTOrigin(this.id, this.name);

  String? id, name;

  factory DTOrigin.fromJson(Map<String, dynamic> json) =>
      _$DTOriginFromJson(json);

  Map<String, dynamic> toJson() => _$DTOriginToJson(this);
}

@JsonSerializable()
class DTLocation {
  DTLocation(this.id, this.name);

  String? id, name;

  factory DTLocation.fromJson(Map<String, dynamic> json) =>
      _$DTLocationFromJson(json);

  Map<String, dynamic> toJson() => _$DTLocationToJson(this);
}
