

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

part 'daily_plan_state.freezed.dart';

@freezed
class DailyPlanState with _$DailyPlanState {
  factory DailyPlanState({
    @Default([]) List<DailyPlanModel> list,
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(false) bool isSaved,
  }) = _DailyPlanState;
}

// class DailyPlanState {
//   DailyPlanState({
//     this.list = const [],
//     this.status = Status.initial,
//     this.saved = false,
//     this.errorMessage,
//   });

//   final List<DailyPlanModel> list;
//   final Status status;
//   final bool saved;
//   final String? errorMessage;
// }
