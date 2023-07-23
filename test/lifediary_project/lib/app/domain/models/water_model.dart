import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';


part 'water_model.freezed.dart';

@freezed
class WaterModel with _$WaterModel {
  factory WaterModel({
    @Default('') String id,
    @Default('') String glasses,
  }) = _WaterModel;
}

// class WaterModel {
//   WaterModel({
//     required this.id,
//     this.glasses = '',
//   });

//   final String id;
//   final String glasses;
// }
