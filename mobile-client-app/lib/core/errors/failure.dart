import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? data;

  const Failure({this.data});

  @override
  List<Object?> get props => [data];
}

class InternetConnectionFailure extends Failure {}

class ServerFailure extends Failure {
  const ServerFailure({super.data});
}

class CacheFailure extends Failure {}

class ClientFailure extends Failure {}

class UnexpectedFailure extends Failure {}

class NotSelectedFailure extends Failure {}