import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';
import 'package:retrofit/retrofit.dart';

part 'weather_remote_data_source.g.dart';

@injectable
@RestApi()
abstract class WeatherRemoteRetrofitDataSource {
  @factoryMethod
  factory WeatherRemoteRetrofitDataSource(@Named('Dio1') Dio dio) =
      _WeatherRemoteRetrofitDataSource;

  @GET("/current.json?key=2f4cf53875c246c7b2a164521231801&aqi=no")
  Future<WeatherModel> getWeatherData(@Query("q") String city);
}


// class WeatherRemoteDataSource {
//   Future<Map<String, dynamic>?> getWeatherData({
//     required String city,
//   }) async {
//     try {
//       final response = await Dio().get<Map<String, dynamic>>(
//           'http://api.weatherapi.com/v1/current.json?key=2f4cf53875c246c7b2a164521231801&q=$city&aqi=no');
//       return response.data;
//     } on DioException catch (error) {
//       throw Exception(
//           error.response?.data['error']['message'] ?? 'Unknown error');
//     }
//   }
// }
