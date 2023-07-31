import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';
import 'package:lifediary_project/app/domain/repositories/weather_repository.dart';
import 'package:meta/meta.dart';

import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherRepository}) : super(WeatherState());

  final WeatherRepository weatherRepository;

  Future<void> getWeatherModel({
    required String city,
  }) async {
    emit(WeatherState(status: Status.loading));
    try {
      final weatherModel = await weatherRepository.getWeatherModel(city: city);
      emit(
        WeatherState(
          model: weatherModel,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        WeatherState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
