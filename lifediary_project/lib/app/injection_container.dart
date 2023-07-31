import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @Named("BaseUrl")
  String get baseUrl => 'http://api.weatherapi.com/v1';

  @Named("SecondUrl")
  String get secondUrl =>
      'https://my-json-server.typicode.com/maciejsulikowski/json-demo';

  @lazySingleton
  @Named("Dio1")
  Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(
        baseUrl: url,
      ));

  @lazySingleton
  @Named("Dio2")
  Dio dioSecondUrl(@Named('SecondUrl') String url) => Dio(BaseOptions(
        baseUrl: url,
      ));
}





// void configureDependencies() {
//   //Bloc
//   getIt.registerFactory(() => WeatherCubit(weatherRepository: getIt()));
//   getIt.registerFactory(() => WaterCubit(getIt()));
//   getIt.registerFactory(() => TrainingCubit(getIt()));
//   getIt.registerFactory(() => AddPhotoCubit(getIt()));
//   getIt.registerFactory(() => ToDoListCubit(getIt()));
//   getIt.registerFactory(() => StoriesCubit(getIt()));
//   getIt.registerFactory(() => QuotesCubit(getIt()));
//   getIt.registerFactory(() => UserCubit(getIt()));
//   getIt.registerFactory(() => DiaresCubit(getIt()));
//   getIt.registerFactory(() => DetailsPhotoCubit(getIt()));
//   getIt.registerFactory(() => DetailsCubit(getIt()));
//   getIt.registerFactory(() => DailyPlanCubit(getIt()));
//   getIt.registerFactory(() => AddCubit(getIt()));
//   getIt.registerFactory(() => RootCubit(getIt(), getIt()));
//   //Repositories
//   getIt.registerFactory(
//       () => WeatherRepository(weatherRemoteDataSource: getIt()));
//   getIt.registerFactory(() => WaterRepository(getIt()));
//   getIt.registerFactory(() => PhotosRepository(getIt()));
//   getIt.registerFactory(() => TasksRepository(getIt()));
//   getIt.registerFactory(() => StoriesRepository(getIt()));
//   getIt.registerFactory(() => QuotesRepository(getIt()));
//   getIt.registerFactory(() => UserRepository(getIt()));
//   getIt.registerFactory(() => ItemsRepository(getIt()));
//   getIt.registerFactory(() => PlansRepository(getIt()));
//   getIt.registerFactory(() => RootRepository(getIt()));

//   //DataSources
//   getIt.registerFactory(() => WeatherRemoteRetrofitDataSource(Dio()));
//   getIt.registerFactory(() => WaterRemoteDataSource());
//   getIt.registerFactory(() => PhotosRemoteDataSource());
//   getIt.registerFactory(() => TasksRemoteDataSource());
//   getIt.registerFactory(() => StoriesRemoteRetrofitDataSource(Dio()));
//   getIt.registerFactory(() => QuotesRemoteRetrofitDataSource(Dio()));
//   getIt.registerFactory(() => UserRemoteDataSource());
//   getIt.registerFactory(() => ItemsRemoteDataSource());
//   getIt.registerFactory(() => PlansRemoteDataSource());
//   getIt.registerFactory(() => RootRemoteDataSource());
// }
