import 'package:data/models/characters/dt_character.dart';

class DTCharactersList {
  DTCharactersList(this.charactersList);

  DTCharactersList.fromJson(Map<String, dynamic> map)
      : charactersList = List<DTCharacter>.from(
          (map['characters']['results'].cast<Map<String, dynamic>>())
              .toList()
              .map(DTCharacter.fromJson),
        );
  final List<DTCharacter> charactersList;

  @override
  String toString() {
    return '$charactersList';
  }
}
