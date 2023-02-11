import 'package:json_annotation/json_annotation.dart';

part 'dt_character_info.g.dart';

@JsonSerializable()
class DTCharacterInfo {
  DTCharacterInfo(
    this.id,
    this.name,
    this.image,
    this.status,
    this.species,
    this.gender,
    this.origin,
    this.location,
  );

  factory DTCharacterInfo.fromJson(Map<String, dynamic> json) =>
      _$DTCharacterInfoFromJson(json);

  final String? id, name, image, status, species, gender;
  final DTOrigin? origin;
  final DTLocation? location;

  Map<String, dynamic> toJson() => _$DTCharacterInfoToJson(this);
}

@JsonSerializable()
class DTOrigin {
  DTOrigin(this.id, this.name);

  factory DTOrigin.fromJson(Map<String, dynamic> json) =>
      _$DTOriginFromJson(json);

  String? id, name;

  Map<String, dynamic> toJson() => _$DTOriginToJson(this);
}

@JsonSerializable()
class DTLocation {
  DTLocation(this.id, this.name);

  factory DTLocation.fromJson(Map<String, dynamic> json) =>
      _$DTLocationFromJson(json);

  String? id, name;

  Map<String, dynamic> toJson() => _$DTLocationToJson(this);
}
