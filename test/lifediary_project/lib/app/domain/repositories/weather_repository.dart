import 'package:dio/dio.dart';
import 'package:lifediary_project/app/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';

class WeatherRepository {
  WeatherRepository(this._weatherRemoteDataSource);

  final WeatherRemoteDataSource _weatherRemoteDataSource;

  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
    final responseData =
        await _weatherRemoteDataSource.getWeatherData(city: city);
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
