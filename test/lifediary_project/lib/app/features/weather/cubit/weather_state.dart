part of 'weather_cubit.dart';

class WeatherState {
  WeatherState({
    this.model,
    this.status = Status.initial,
    this.errorMessage,
  });

  final WeatherModel? model;
  final Status status;
  final String? errorMessage;
}
