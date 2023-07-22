import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';

part 'water_state.freezed.dart';

@freezed
class WaterState with _$WaterState {
  factory WaterState({
    WaterModel? glasses,
    @Default(false) bool isSaved,
    @Default(Status.initial) Status status,
  }) = _WaterState;
}

// @immutable
// class WaterState {
//   WaterState({
//     required this.glasses,
//     this.isSaved = false,
//     this.status = Status.initial,
//   });

//   final WaterModel? glasses;
//   final bool isSaved;
//   final Status status;
// }
