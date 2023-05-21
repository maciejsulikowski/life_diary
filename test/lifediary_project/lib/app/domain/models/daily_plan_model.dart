import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyPlanModel {
  DailyPlanModel({
    required this.id,
    this.text = '',
    required this.time,
  });

  final String id;
  String text;
  final String time;
}
