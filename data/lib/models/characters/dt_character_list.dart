import 'package:data/models/characters/dt_character.dart';

class DTCharactersList {
  final List<DTCharacter> charactersList;

  DTCharactersList(this.charactersList);

  DTCharactersList.fromJson(Map<String, dynamic> map)
      : charactersList = List<DTCharacter>.from(
            (map['characters']['results'].cast<Map<String, dynamic>>())
                .toList()
                .map((map) => DTCharacter.fromJson(map)));

  @override
  String toString() {
    return '$charactersList';
  }
}
