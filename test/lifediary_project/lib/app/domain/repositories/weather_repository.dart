import 'package:dio/dio.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';

class WeatherRepository {
  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
    final response = await Dio().get<Map<String, dynamic>>(
        'http://api.weatherapi.com/v1/current.json?key=2f4cf53875c246c7b2a164521231801&q=$city&aqi=no');
    final responseData = response.data;
    if (responseData == null) {
      return null;
    }
    final name = responseData['location']['name'] as String;
    final temp = (responseData['current']['temp_c'] + 0.0) as double;

    return WeatherModel(
      temperature: temp,
      city: name,
    );
  }
}
