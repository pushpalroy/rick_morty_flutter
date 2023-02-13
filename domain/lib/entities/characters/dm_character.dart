class Character {
  Character(this.id, this.name, this.image, this.status, this.species);

  final String id;
  final String name;
  final String image;
  final String status;
  final String species;
}

class CharacterList {
  CharacterList(this.characterList);

  final List<Character> characterList;
}
