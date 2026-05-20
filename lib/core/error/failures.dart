abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server Error']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache Error']) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Validation Error']) : super(message);
}

class RateLimitFailure extends Failure {
  const RateLimitFailure([String message = 'Too many requests']) : super(message);
}
