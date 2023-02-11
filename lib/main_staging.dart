import 'package:rick_morty_flutter/application/platform_app.dart';
import 'package:rick_morty_flutter/bootstrap.dart';

const staging = 'staging';

void main() async {
  await bootstrap(() => const RickMortyApp(), staging);
}
