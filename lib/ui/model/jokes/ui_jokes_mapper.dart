import 'package:injectable/injectable.dart';
import 'package:rick_morty_flutter/ui/model/jokes/ui_joke.dart';
import 'package:domain/mapper/ui_model_mapper.dart';
import 'package:domain/entities/jokes/dm_joke_list.dart';
import 'package:domain/entities/jokes/dm_joke.dart';

@injectable
class UIJokeMapper extends UiModelMapper<JokesListWithType, UIJokeList> {
  @override
  JokesListWithType mapToDomain(UIJokeList modelItem) {
    return JokesListWithType(
        modelItem.jokes.map((e) => Joke(e.id, e.value)).toList());
  }

  @override
  UIJokeList mapToPresentation(JokesListWithType model) {
    return UIJokeList(model.jokeList.map((e) => UiJoke(e.id, e.value)).toList());
  }
}
