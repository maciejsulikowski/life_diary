import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';

part 'weather_state.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
   factory WeatherState({
    WeatherModel? model,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _WeatherState;
}



// class WeatherState {
//   WeatherState({
//     this.model,
//     this.status = Status.initial,
//     this.errorMessage,
//   });

//   final WeatherModel? model;
//   final Status status;
//   final String? errorMessage;
// }
