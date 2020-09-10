import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

//GeneralFailures

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}