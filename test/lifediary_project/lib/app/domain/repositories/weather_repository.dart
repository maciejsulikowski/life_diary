import 'package:dio/dio.dart';
import 'package:lifediary_project/app/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';

class WeatherRepository {
  WeatherRepository(this._weatherRemoteDataSource);

  final WeatherRemoteDataSource _weatherRemoteDataSource;

  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
    final json = await _weatherRemoteDataSource.getWeatherData(city: city);
    if (json == null) {
      return null;
    }
    final locationName = json['location']['name'] as String;
    final currentTemp = (json['current']['temp_c'] + 0.0) as double;

    return WeatherModel(currentTemp, locationName);
  }
}
