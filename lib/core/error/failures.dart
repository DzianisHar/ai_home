import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error']) : super(message);
}

class NoInternetFailure extends Failure {
  const NoInternetFailure() : super('No internet connection');
}

class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'Unknown error']) : super(message);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure([String message = 'Invalid input']) : super(message);
}
