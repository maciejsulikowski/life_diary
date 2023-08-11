import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';
import 'package:lifediary_project/app/domain/repositories/weather_repository.dart';
import 'package:lifediary_project/app/features/weather/cubit/weather_cubit.dart';
import 'package:lifediary_project/app/features/weather/cubit/weather_state.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late WeatherCubit sut;
  late MockWeatherRepository repository;

  setUp(() {
    repository = MockWeatherRepository();
    sut = WeatherCubit(weatherRepository: repository);
  });

  group('getWeatherModel', () {
    final expectedWeather = WeatherModel(
        location: Location(name: 'Warszawa'),
        current: CurrentCondition(temp_c: 10.5));
    group('success', () {
      setUp(() {
        when(() => repository.getWeatherModel(city: 'Warszawa'))
            .thenAnswer((_) async => expectedWeather);
      });

      blocTest<WeatherCubit, WeatherState>(
        'emits Status.loading then Status.succes with model',
        build: () => sut,
        act: (cubit) => cubit.getWeatherModel(city: 'Warszawa'),
        expect: () => [
          WeatherState(
            status: Status.loading,
          ),
          WeatherState(
            status: Status.success,
            model: expectedWeather,
          ),
        ],
      );
    });
  });
}
