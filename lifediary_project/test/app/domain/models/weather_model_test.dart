import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';

void main() {
  test("should getter return temperature with °C combined", () {
    final model = CurrentCondition(temp_c: 10.5);

    final result = model.temp;

    expect(result, '10.5 °C');
  });

  test('Location creates instance from JSON', () {
    final location = Location(name: 'name');

    final name = location.name;

    expect(Location(name: name), isA<Location>());
  });

  test('CurrentCondition creates instance from JSON', () {
    final current = CurrentCondition(temp_c: 10.5);

    final temp = current.temp_c;

    expect(CurrentCondition(temp_c: temp), isA<CurrentCondition>());
  });

  test(
      'should create an instance of WeatherModel from Location and CurrenCondition',
      () {
    final location = Location(name: 'name');
    final currentCondition = CurrentCondition(temp_c: 10.5);

    final weatherModel =
        WeatherModel(current: currentCondition, location: location);

    expect(weatherModel, isA<WeatherModel>());
  });

  test('should create an instance of Location', () {
    final location = Location(name: 'name');

    expect(location, isA<Location>());
  });

  test('should create an instance of CurrentCondition', () {
    final current = CurrentCondition(temp_c: 10.5);

    expect(current, isA<CurrentCondition>());
  });

  test('fromJson should create a WeatherModel object', () {
    final json = {
      'location': {'name': 'New York'},
      'current': {'temp_c': 10.5},
    };

    final weatherModel = WeatherModel.fromJson(json);

    expect(weatherModel.location.name, equals('New York'));
    expect(weatherModel.current.temp_c, equals(10.5));
  });

  test('fromJson should create a Location object', () {
    final json = {
      'name': 'New York',
      
    };

    final location = Location.fromJson(json);

    expect(location.name, equals('New York'));
  });

  test('fromJson should create a CurrentCondition object', () {
    final json = {
      'temp_c': 10.5,
    };

    final current = CurrentCondition.fromJson(json);

    expect(current.temp_c, equals(10.5));
  });
}
