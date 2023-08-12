// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i25;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:lifediary_project/app/cubit/root_cubit.dart' as _i28;
import 'package:lifediary_project/app/data/remote_data_sources/items_remote_data_source.dart'
    as _i3;
import 'package:lifediary_project/app/data/remote_data_sources/photos_remote_data_source.dart'
    as _i5;
import 'package:lifediary_project/app/data/remote_data_sources/plans_remote_data_sources.dart'
    as _i7;
import 'package:lifediary_project/app/data/remote_data_sources/quotes_remote_data_source.dart'
    as _i26;
import 'package:lifediary_project/app/data/remote_data_sources/root_remote_data_source.dart'
    as _i9;
import 'package:lifediary_project/app/data/remote_data_sources/stories_remote_data_source.dart'
    as _i29;
import 'package:lifediary_project/app/data/remote_data_sources/tasks_remote_data_sources.dart'
    as _i11;
import 'package:lifediary_project/app/data/remote_data_sources/user_remote_data_source.dart'
    as _i15;
import 'package:lifediary_project/app/data/remote_data_sources/water_remote_data_source.dart'
    as _i17;
import 'package:lifediary_project/app/data/remote_data_sources/weather_remote_data_source.dart'
    as _i33;
import 'package:lifediary_project/app/domain/repositories/items_repository.dart'
    as _i4;
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart'
    as _i6;
import 'package:lifediary_project/app/domain/repositories/plans_repository.dart'
    as _i8;
import 'package:lifediary_project/app/domain/repositories/quotes_repository.dart'
    as _i27;
import 'package:lifediary_project/app/domain/repositories/root_repository.dart'
    as _i10;
import 'package:lifediary_project/app/domain/repositories/stories_repository.dart'
    as _i30;
import 'package:lifediary_project/app/domain/repositories/tasks_repository.dart'
    as _i12;
import 'package:lifediary_project/app/domain/repositories/user_repository.dart'
    as _i16;
import 'package:lifediary_project/app/domain/repositories/water_repository.dart'
    as _i18;
import 'package:lifediary_project/app/domain/repositories/weather_repository.dart'
    as _i34;
import 'package:lifediary_project/app/features/add_page/cubit/add_cubit.dart'
    as _i19;
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_cubit.dart'
    as _i21;
import 'package:lifediary_project/app/features/details/cubit/details_cubit.dart'
    as _i22;
import 'package:lifediary_project/app/features/details_photo/cubit/details_photo_cubit.dart'
    as _i23;
import 'package:lifediary_project/app/features/diaries/cubit/diares_cubit.dart'
    as _i24;
import 'package:lifediary_project/app/features/login/cubit/user_cubit.dart'
    as _i31;
import 'package:lifediary_project/app/features/quotes/cubit/quotes_cubit.dart'
    as _i35;
import 'package:lifediary_project/app/features/stories/cubit/stories_cubit.dart'
    as _i36;
import 'package:lifediary_project/app/features/to_do_list/cubit/to_do_list_cubit.dart'
    as _i13;
import 'package:lifediary_project/app/features/training/add_photos/cubit/add_photo_cubit.dart'
    as _i20;
import 'package:lifediary_project/app/features/training/cubit/training_cubit.dart'
    as _i14;
import 'package:lifediary_project/app/features/water/cubit/water_cubit.dart'
    as _i32;
import 'package:lifediary_project/app/features/weather/cubit/weather_cubit.dart'
    as _i37;
import 'package:lifediary_project/app/injection_container.dart' as _i38;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.ItemsRemoteDataSource>(() => _i3.ItemsRemoteDataSource());
    gh.factory<_i4.ItemsRepository>(
        () => _i4.ItemsRepository(gh<_i3.ItemsRemoteDataSource>()));
    gh.factory<_i5.PhotosRemoteDataSource>(() => _i5.PhotosRemoteDataSource());
    gh.factory<_i6.PhotosRepository>(
        () => _i6.PhotosRepository(gh<_i5.PhotosRemoteDataSource>()));
    gh.factory<_i7.PlansRemoteDataSource>(() => _i7.PlansRemoteDataSource());
    gh.factory<_i8.PlansRepository>(
        () => _i8.PlansRepository(gh<_i7.PlansRemoteDataSource>()));
    gh.factory<_i9.RootRemoteDataSource>(() => _i9.RootRemoteDataSource());
    gh.factory<_i10.RootRepository>(
        () => _i10.RootRepository(gh<_i9.RootRemoteDataSource>()));
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<String>(
      () => registerModule.secondUrl,
      instanceName: 'SecondUrl',
    );
    gh.factory<_i11.TasksRemoteDataSource>(() => _i11.TasksRemoteDataSource());
    gh.factory<_i12.TasksRepository>(
        () => _i12.TasksRepository(gh<_i11.TasksRemoteDataSource>()));
    gh.factory<_i13.ToDoListCubit>(
        () => _i13.ToDoListCubit(gh<_i12.TasksRepository>()));
    gh.factory<_i14.TrainingCubit>(
        () => _i14.TrainingCubit(gh<_i6.PhotosRepository>()));
    gh.factory<_i15.UserRemoteDataSource>(() => _i15.UserRemoteDataSource());
    gh.factory<_i16.UserRepository>(
        () => _i16.UserRepository(gh<_i15.UserRemoteDataSource>()));
    gh.factory<_i17.WaterRemoteDataSource>(() => _i17.WaterRemoteDataSource());
    gh.factory<_i18.WaterRepository>(
        () => _i18.WaterRepository(gh<_i17.WaterRemoteDataSource>()));
    gh.factory<_i19.AddCubit>(() => _i19.AddCubit(gh<_i4.ItemsRepository>()));
    gh.factory<_i20.AddPhotoCubit>(
        () => _i20.AddPhotoCubit(gh<_i6.PhotosRepository>()));
    gh.factory<_i21.DailyPlanCubit>(
        () => _i21.DailyPlanCubit(gh<_i8.PlansRepository>()));
    gh.factory<_i22.DetailsCubit>(
        () => _i22.DetailsCubit(gh<_i4.ItemsRepository>()));
    gh.factory<_i23.DetailsPhotoCubit>(
        () => _i23.DetailsPhotoCubit(gh<_i6.PhotosRepository>()));
    gh.factory<_i24.DiaresCubit>(
        () => _i24.DiaresCubit(gh<_i4.ItemsRepository>()));
    gh.lazySingleton<_i25.Dio>(
      () => registerModule.dioSecondUrl(gh<String>(instanceName: 'SecondUrl')),
      instanceName: 'Dio2',
    );
    gh.lazySingleton<_i25.Dio>(
      () => registerModule.dio(gh<String>(instanceName: 'BaseUrl')),
      instanceName: 'Dio1',
    );
    gh.factory<_i26.QuotesRemoteRetrofitDataSource>(() =>
        _i26.QuotesRemoteRetrofitDataSource(
            gh<_i25.Dio>(instanceName: 'Dio2')));
    gh.factory<_i27.QuotesRepository>(
        () => _i27.QuotesRepository(gh<_i26.QuotesRemoteRetrofitDataSource>()));
    gh.factory<_i28.RootCubit>(() => _i28.RootCubit(
          gh<_i16.UserRepository>(),
          gh<_i10.RootRepository>(),
        ));
    gh.factory<_i29.StoriesRemoteRetrofitDataSource>(() =>
        _i29.StoriesRemoteRetrofitDataSource(
            gh<_i25.Dio>(instanceName: 'Dio2')));
    gh.factory<_i30.StoriesRepository>(() =>
        _i30.StoriesRepository(gh<_i29.StoriesRemoteRetrofitDataSource>()));
    gh.factory<_i31.UserCubit>(() => _i31.UserCubit(gh<_i16.UserRepository>()));
    gh.factory<_i32.WaterCubit>(
        () => _i32.WaterCubit(gh<_i18.WaterRepository>()));
    gh.factory<_i33.WeatherRemoteRetrofitDataSource>(() =>
        _i33.WeatherRemoteRetrofitDataSource(
            gh<_i25.Dio>(instanceName: 'Dio1')));
    gh.factory<_i34.WeatherRepository>(() => _i34.WeatherRepository(
        weatherRemoteDataSource: gh<_i33.WeatherRemoteRetrofitDataSource>()));
    gh.factory<_i35.QuotesCubit>(
        () => _i35.QuotesCubit(gh<_i27.QuotesRepository>()));
    gh.factory<_i36.StoriesCubit>(
        () => _i36.StoriesCubit(gh<_i30.StoriesRepository>()));
    gh.factory<_i37.WeatherCubit>(() =>
        _i37.WeatherCubit(weatherRepository: gh<_i34.WeatherRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i38.RegisterModule {}
