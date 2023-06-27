import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherModel {
  const WeatherModel({
    required this.temperature,
    required this.city,
  });

  final double temperature;
  final String city;

  String get temp {
    return '$temperature °C';
  }

  WeatherModel.fromJson(Map<String, dynamic> json)
      : temperature = json['current']['temp_c'] + 0.0,
        city = json['location']['name'];
}
