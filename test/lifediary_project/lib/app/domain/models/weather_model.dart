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
    required String region,
    required String country,
    required double lat,
    required double lon,
    required String tz_id,
    required int localtime_epoch,
    required String localtime,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class CurrentCondition with _$CurrentCondition {
  CurrentCondition._();
  factory CurrentCondition({
    required int last_updated_epoch,
    required String last_updated,
    required double temp_c,
    required double temp_f,
    required int is_day,
    required WeatherCondition condition,
    required double wind_mph,
    required double wind_kph,
    required int wind_degree,
    required String wind_dir,
    required double pressure_mb,
    required double pressure_in,
    required double precip_mm,
    required double precip_in,
    required int humidity,
    required int cloud,
    required double feelslike_c,
    required double feelslike_f,
    required double vis_km,
    required double vis_miles,
    required double uv,
    required double gust_mph,
    required double gust_kph,
  }) = _CurrentCondition;

  String get temp {
    return '$temp_c °C';
  }

  factory CurrentCondition.fromJson(Map<String, dynamic> json) =>
      _$CurrentConditionFromJson(json);
}

@freezed
class WeatherCondition with _$WeatherCondition {
  factory WeatherCondition({
    required String text,
    required String icon,
    required int code,
  }) = _WeatherCondition;

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionFromJson(json);
}
