import 'package:json_annotation/json_annotation.dart';

part 'dt_character.g.dart';

@JsonSerializable()
class DTCharacter {
  DTCharacter(this.id, this.name, this.image, this.status, this.species);

  factory DTCharacter.fromJson(Map<String, dynamic> json) =>
      _$DTCharacterFromJson(json);

  String id, name, image, status, species;

  Map<String, dynamic> toJson() => _$DTCharacterToJson(this);
}
