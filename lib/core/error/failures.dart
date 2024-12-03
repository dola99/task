import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class LocalFailure extends Failure {
  const LocalFailure(String message) : super(message);
}

class ParseFailure extends Failure {
  const ParseFailure(String message) : super(message);
}
