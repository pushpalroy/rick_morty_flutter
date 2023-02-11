abstract class UiState<T> {}

class Initial<T> extends UiState<T> {}

class Loading<T> extends UiState<T> {}

class Success<T> extends UiState<T> {
  Success({required this.data});

  T data;
}

class Failure<T> extends UiState<T> {
  Failure({required this.exception});

  Exception exception;
}
