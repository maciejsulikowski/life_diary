import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:lifediary_project/app/domain/repositories/weather_repository.dart';
import 'package:lifediary_project/app/features/weather/cubit/weather_cubit.dart';
import 'package:lifediary_project/app/injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @Named("BaseUrl")
  String get baseUrl => 'http://api.weatherapi.com/v1';

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(baseUrl: url));

}
// void configureDependencies() {
//   //Bloc
//   getIt.registerFactory(() => WeatherCubit(weatherRepository: getIt()));

//   //Repositories
//   getIt.registerFactory(
//       () => WeatherRepository(weatherRemoteDataSource: getIt()));

//   //DataSources
//   getIt.registerFactory(() => WeatherRemoteRetrofitDataSource(Dio()));
// }
