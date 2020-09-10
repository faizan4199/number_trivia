import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:random_numbers/core/network/network_info.dart';
import 'package:random_numbers/core/util/input_converter.dart';
import 'package:random_numbers/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:random_numbers/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:random_numbers/features/number_trivia/data/repositories/number_trivia_repositories_impl.dart';
import 'package:random_numbers/features/number_trivia/domain/repositories/number_trivia.dart';
import 'package:random_numbers/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:random_numbers/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:random_numbers/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  /// Features
  sl.registerFactory(
    () => NumberTriviaBloc(
      concrete: sl(),
      inputConverter: sl(),
      random: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetConcreteNumberTrivia());
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  /// Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
