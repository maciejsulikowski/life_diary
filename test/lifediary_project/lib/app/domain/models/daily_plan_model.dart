import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'daily_plan_model.freezed.dart';

@freezed
class DailyPlanModel with _$DailyPlanModel {
  factory DailyPlanModel({
    required String id,
    @Default('') String text,
    required String time,
  }) = _DailyPlanModel;
}

// class DailyPlanModel {
//   DailyPlanModel({
//     required this.id,
//     this.text = '',
//     required this.time,
//   });

//   final String id;
//   String text;
//   final String time;
// }
