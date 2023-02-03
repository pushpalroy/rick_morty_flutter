abstract class UiState<T> {}

class Initial<T> extends UiState<T> {}

class Loading<T> extends UiState<T> {}

class Success<T> extends UiState<T> {
  T data;

  Success({required this.data});
}

class Failure<T> extends UiState<T> {
  Exception exception;

  Failure({required this.exception});
}
