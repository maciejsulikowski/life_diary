import 'package:lifediary_project/app/domain/models/weather_model.dart';

class WeatherRepository {
  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
    //http://api.weatherapi.com/v1/current.json?key=2f4cf53875c246c7b2a164521231801&q=Olsztyn&aqi=no
    return WeatherModel(
      temperature: -6.5,
      city: 'Warsaw',
    );
  }
}
