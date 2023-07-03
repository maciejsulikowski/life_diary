import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.g.dart';
part 'weather_model.freezed.dart';

@freezed
class WeatherModel with _$WeatherModel {
  WeatherModel._();
  factory WeatherModel(
    @JsonKey(name: 'temp_c') double temperature,
    @JsonKey(name: 'name') String city,
      
  ) = _WeatherModel;

  String get temp {
    return '$temperature °C';
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}


// @JsonSerializable()
// class WeatherModel {
//   const WeatherModel({
//     required this.temperature,
//     required this.city,
//   });

//   @JsonKey(
//     name: 'temp_c',
//   )
//   final double temperature;

//   @JsonKey(
//     name: 'name',
//   )
//   final String city;

  // String get temp {
  //   return '$temperature °C';
  // }

//   factory WeatherModel.fromJson(Map<String, dynamic> json) =>
//       _$WeatherModelFromJson(json);

//   Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
// }
