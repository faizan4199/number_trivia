import 'package:dartz/dartz.dart';

import 'package:random_numbers/core/error/failures.dart';
import 'package:random_numbers/core/usecases/usecase.dart';
import 'package:random_numbers/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:random_numbers/features/number_trivia/domain/repositories/number_trivia.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
