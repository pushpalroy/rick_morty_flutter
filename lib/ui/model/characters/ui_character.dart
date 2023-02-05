import 'package:rick_morty_flutter/ui/model/ui_model.dart';

class UiCharacter extends UIModel {
  String name;
  String image;

  UiCharacter(this.name, this.image);
}

class UiCharacterList extends UIModel {
  List<UiCharacter> characters;

  UiCharacterList(this.characters);
}
