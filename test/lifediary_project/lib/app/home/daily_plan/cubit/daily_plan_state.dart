
part of 'daily_plan_cubit.dart';


class DailyPlanState {
  DailyPlanState({
    this.list = const [],
    this.isLoading = false,
    this.saved = false,
    this.errorMessage = '',
  });

  final List<DailyPlanModel>? list;
  final bool isLoading;
  final bool saved;
  final String errorMessage;
}
