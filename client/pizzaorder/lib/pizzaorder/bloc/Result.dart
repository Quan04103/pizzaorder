sealed class Result<T> {
  get message => null;
}

class Success<T> extends Result<T> {
  Success(this.data);

  final T data;
}

class Failure<T> extends Result<T> {
  Failure(this.message);

  final String message;
}
