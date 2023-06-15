part of 'daily_plan_cubit.dart';

class DailyPlanState {
  DailyPlanState({
    this.list = const [],
    this.status = Status.initial,
    this.saved = false,
    this.errorMessage,
  });

  final List<DailyPlanModel> list;
  final Status status;
  final bool saved;
  final String? errorMessage;
}
