import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/data/remote_data_sources/items_remote_data_source.dart';
import 'package:lifediary_project/app/data/remote_data_sources/photos_remote_data_source.dart';
import 'package:lifediary_project/app/data/remote_data_sources/plans_remote_data_sources.dart';
import 'package:lifediary_project/app/data/remote_data_sources/quotes_remote_data_source.dart';
import 'package:lifediary_project/app/data/remote_data_sources/root_remote_data_source.dart';
import 'package:lifediary_project/app/data/remote_data_sources/stories_remote_data_source.dart';
import 'package:lifediary_project/app/data/remote_data_sources/tasks_remote_data_sources.dart';
import 'package:lifediary_project/app/data/remote_data_sources/user_remote_data_source.dart';
import 'package:lifediary_project/app/data/remote_data_sources/water_remote_data_source.dart';
import 'package:lifediary_project/app/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:lifediary_project/app/domain/repositories/plans_repository.dart';
import 'package:lifediary_project/app/domain/repositories/quotes_repository.dart';
import 'package:lifediary_project/app/domain/repositories/root_repository.dart';
import 'package:lifediary_project/app/domain/repositories/stories_repository.dart';
import 'package:lifediary_project/app/domain/repositories/tasks_repository.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:lifediary_project/app/domain/repositories/water_repository.dart';
import 'package:lifediary_project/app/domain/repositories/weather_repository.dart';
import 'package:lifediary_project/app/features/add_page/cubit/add_cubit.dart';
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_cubit.dart';
import 'package:lifediary_project/app/features/details/cubit/details_cubit.dart';
import 'package:lifediary_project/app/features/details_photo/cubit/details_photo_cubit.dart';
import 'package:lifediary_project/app/features/diaries/cubit/diares_cubit.dart';
import 'package:lifediary_project/app/features/login/cubit/user_cubit.dart';
import 'package:lifediary_project/app/features/quotes/cubit/quotes_cubit.dart';
import 'package:lifediary_project/app/features/stories/cubit/stories_cubit.dart';
import 'package:lifediary_project/app/features/to_do_list/cubit/to_do_list_cubit.dart';
import 'package:lifediary_project/app/features/training/add_photos/cubit/add_photo_cubit.dart';
import 'package:lifediary_project/app/features/training/cubit/training_cubit.dart';
import 'package:lifediary_project/app/features/water/cubit/water_cubit.dart';
import 'package:lifediary_project/app/features/weather/cubit/weather_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  //Bloc
  getIt.registerFactory(() => WeatherCubit(weatherRepository: getIt()));
  getIt.registerFactory(() => WaterCubit(getIt()));
  getIt.registerFactory(() => TrainingCubit(getIt()));
  getIt.registerFactory(() => AddPhotoCubit(getIt()));
  getIt.registerFactory(() => ToDoListCubit(getIt()));
  getIt.registerFactory(() => StoriesCubit(getIt()));
  getIt.registerFactory(() => QuotesCubit(getIt()));
  getIt.registerFactory(() => UserCubit(getIt()));
  getIt.registerFactory(() => DiaresCubit(getIt()));
  getIt.registerFactory(() => DetailsPhotoCubit(getIt()));
  getIt.registerFactory(() => DetailsCubit(getIt()));
  getIt.registerFactory(() => DailyPlanCubit(getIt()));
  getIt.registerFactory(() => AddCubit(getIt()));
  getIt.registerFactory(() => RootCubit(getIt(), getIt()));
  //Repositories
  getIt.registerFactory(
      () => WeatherRepository(weatherRemoteDataSource: getIt()));
  getIt.registerFactory(() => WaterRepository(getIt()));
  getIt.registerFactory(() => PhotosRepository(getIt()));
  getIt.registerFactory(() => TasksRepository(getIt()));
  getIt.registerFactory(() => StoriesRepository(getIt()));
  getIt.registerFactory(() => QuotesRepository(getIt()));
  getIt.registerFactory(() => UserRepository(getIt()));
  getIt.registerFactory(() => ItemsRepository(getIt()));
  getIt.registerFactory(() => PlansRepository(getIt()));
  getIt.registerFactory(() => RootRepository(getIt()));

  //DataSources
  getIt.registerFactory(() => WeatherRemoteRetrofitDataSource(Dio()));
  getIt.registerFactory(() => WaterRemoteDataSource());
  getIt.registerFactory(() => PhotosRemoteDataSource());
  getIt.registerFactory(() => TasksRemoteDataSource());
  getIt.registerFactory(() => StoriesRemoteRetrofitDataSource(Dio()));
  getIt.registerFactory(() => QuotesRemoteRetrofitDataSource(Dio()));
  getIt.registerFactory(() => UserRemoteDataSource());
  getIt.registerFactory(() => ItemsRemoteDataSource());
  getIt.registerFactory(() => PlansRemoteDataSource());
  getIt.registerFactory(() => RootRemoteDataSource());
}
