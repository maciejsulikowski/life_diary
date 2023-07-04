import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lifediary_project/app/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:lifediary_project/app/domain/repositories/weather_repository.dart';
import 'package:lifediary_project/app/features/weather/cubit/weather_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  //Bloc
  getIt.registerFactory(() => WeatherCubit(weatherRepository: getIt()));

  //Repositories
  getIt.registerFactory(
      () => WeatherRepository(weatherRemoteDataSource: getIt()));

  //DataSources
  getIt.registerFactory(() => WeatherRemoteRetrofitDataSource(Dio()));
}
