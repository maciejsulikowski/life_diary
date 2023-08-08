import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';
import 'package:lifediary_project/app/domain/repositories/weather_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherDataSource extends Mock
    implements WeatherRemoteRetrofitDataSource {}

void main() {
  late WeatherRepository sut;
  late MockWeatherDataSource dataSource;

  setUp(() {
    dataSource = MockWeatherDataSource();
    sut = WeatherRepository(weatherRemoteDataSource: dataSource);
  });

  group('getWeatherModel', () {
    const String city = 'Warszawa';
    final expectedWeather = WeatherModel(
        location: Location(name: city),
        current: CurrentCondition(temp_c: 10.5));

    test('should call weatherRemoteDataSource.getWeatherData() method',
        () async {
      //1
      when(() => dataSource.getWeatherData(city)).thenAnswer(
        (_) async => expectedWeather,
      );
      //2
      await sut.getWeatherModel(city: city);
      //3
      verify(() => dataSource.getWeatherData(city)).called(1);
    });
    test('should return WeatherModel successful', () async {
      //1
      when(() => dataSource.getWeatherData(city)).thenAnswer(
        (_) async => expectedWeather,
      );
      //2
      final results = await sut.getWeatherModel(city: city);
      //3
      expect(results, expectedWeather);
    });
  });
}
