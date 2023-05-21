import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaterModel {
  WaterModel({
    required this.id,
    this.glasses = '',
  });

  final String id;
  final String glasses;
}
