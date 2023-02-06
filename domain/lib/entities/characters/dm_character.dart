class Character {
  final String id;
  final String name;
  final String image;
  final String status;
  final String species;

  Character(this.id, this.name, this.image, this.status, this.species);
}

class CharacterList {
  final List<Character> characterList;

  CharacterList(this.characterList);
}
