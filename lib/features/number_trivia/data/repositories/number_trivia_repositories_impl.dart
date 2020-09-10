import 'package:flutter/material.dart';
import 'package:random_numbers/core/error/exceptions.dart';
import 'package:random_numbers/core/network/network_info.dart';
import 'package:random_numbers/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:random_numbers/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:random_numbers/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:random_numbers/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:random_numbers/features/number_trivia/domain/repositories/number_trivia.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChoose();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChoose getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
