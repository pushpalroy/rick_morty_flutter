import 'package:rick_morty_flutter/ui/model/ui_model.dart';

class UiLocation extends UIModel {
  String id, name, type, dimension, created;

  UiLocation(this.id, this.name, this.type, this.dimension, this.created);
}

class UiLocationList extends UIModel {
  List<UiLocation> locations;

  UiLocationList(this.locations);
}
