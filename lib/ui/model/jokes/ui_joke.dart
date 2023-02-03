import 'package:rick_morty_flutter/ui/model/ui_model.dart';


class UiJoke extends UIModel {
  String value;
  String id;

  UiJoke(this.id, this.value);
}

class UIJokeList extends UIModel {
  List<UiJoke> jokes;

  UIJokeList(this.jokes);
}