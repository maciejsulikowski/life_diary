import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.g.dart';
part 'weather_model.freezed.dart';

@freezed
class WeatherModel with _$WeatherModel {
  factory WeatherModel({
    required Location location,
    required CurrentCondition current,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

@freezed
class Location with _$Location {
  factory Location({
    required String name,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class CurrentCondition with _$CurrentCondition {
  CurrentCondition._();
  factory CurrentCondition({
    
    required double temp_c,
    
    
  }) = _CurrentCondition;

  String get temp {
    return '$temp_c °C';
  }

  factory CurrentCondition.fromJson(Map<String, dynamic> json) =>
      _$CurrentConditionFromJson(json);
}


