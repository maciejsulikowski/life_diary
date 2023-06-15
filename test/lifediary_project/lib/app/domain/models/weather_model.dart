import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherModel {
  const WeatherModel({
    required this.temperature,
    required this.city,
  });

  final double temperature;
  final String city;
}
