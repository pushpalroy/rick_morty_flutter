## Rick & Morty - Flutter

  <p align="left"> A Flutter clean-architecture project that uses BLoC and GraphQL with best practices. Includes e2e integration tests, widget tests and unit tests.</p>

  <p align="left">
      <a href = "https://github.com/Solido/awesome-flutter">
        <img src = "https://img.shields.io/badge/Awesome-Flutter-blue.svg?color=blue&style=for-the-badge" />
      </a>
      <a href = "https://github.com/pushpalroy/rick_morty_flutter/stargazers">
        <img src="https://img.shields.io/github/stars/pushpalroy/rick_morty_flutter?color=green&style=for-the-badge" />
      </a>
      <a href = "https://github.com/pushpalroy/rick_morty_flutter/network/members">
          <img src="https://img.shields.io/github/forks/pushpalroy/rick_morty_flutter?color=green&style=for-the-badge" />
      </a>
      <a href = "https://github.com/pushpalroy/rick_morty_flutter/watchers">
          <img src="https://img.shields.io/github/watchers/pushpalroy/rick_morty_flutter?color=yellowgreen&style=for-the-badge" />
      </a>
      <a href = "https://github.com/pushpalroy/rick_morty_flutter/issues">
          <img src="https://img.shields.io/github/issues/pushpalroy/rick_morty_flutter?color=orange&style=for-the-badge" />
      </a>
  </p>

### 👨‍💻 Tech stack

| Tools               | Link                                                            |
|:--------------------|:----------------------------------------------------------------|
| 🤖 State Management | [flutter_bloc](https://pub.dev/packages/flutter_bloc)           |
| 💚 Service Locator  | [get_it](https://pub.dev/packages/get_it)                       |
| 💉 DI               | [injectable](https://pub.dev/packages/injectable)               |
| 🏛 Navigation       | [go_router](https://pub.dev/packages/go_router)                 |
| 🌊 GraphQL client   | [graphql_flutter](https://pub.dev/packages/graphql_flutter)     |
| 🌐 Network State    | [connectivity_plus](https://pub.dev/packages/connectivity_plus) |
| 📄 Serialization    | [json_serializable](https://pub.dev/packages/json_serializable) |
| 💬 Lint             | [pedantic_mono](https://pub.dev/packages/pedantic_mono)         |
| 🚀 BloC Test        | [bloc_test](https://pub.dev/packages/bloc_test)                 |
| 🖊️ Mock            | [mockito](https://pub.dev/packages/mockito)                     |

### ⚒️ Architecture

Rick & Morty Flutter follows the principles of Clean Architecture.
The project architecture has been inspired
from [Praxis Flutter](https://github.com/mutualmobile/PraxisFlutter).

### 🖥️ Screens

<table style="width:100%">
  <tr>
    <th>Characters</th>
    <th>Characters Info</th> 
    <th>Locations</th>
  </tr>
  <tr>
    <td><img src = "art/characters.png" width=240/></td> 
    <td><img src = "art/character_info.png" width=240/></td>
    <td><img src = "art/locations.png" width=240/></td>
  </tr>
</table>

### How to run the project? ✅

To generate code for injectable, json serialization and mockito

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

### How to run tests? ✅

Integration tests

```
flutter drive \
--driver=test_driver/integration_test.dart \
--target=integration_test/app_test.dart \
--flavor=development
```

Unit tests

```
flutter test \
test/repository/characters_repo_test.dart
--flavor=development
```

### Find this project useful ? ❤️

- Support it by clicking the ⭐️ button on the upper right of this page. ✌️

### License

```
MIT License

Copyright (c) 2022 Pushpal Roy

Permission is hereby granted, free of charge, to any person obtaining a 
copy of this software and associated documentation files (the "Software"), 
to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included 
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
