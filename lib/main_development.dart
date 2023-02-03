import 'package:injectable/injectable.dart';
import 'package:rick_morty_flutter/application/platform_app.dart';
import 'package:rick_morty_flutter/bootstrap.dart';

void main() async {
  bootstrap(() => const RickMortyApp(), Environment.dev);
}
