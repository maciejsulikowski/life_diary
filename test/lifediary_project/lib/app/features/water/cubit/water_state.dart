part of 'water_cubit.dart';

@immutable
class WaterState {
  WaterState({
    required this.glasses,
    this.isSaved = false,
    this.status = Status.initial,
  });

  final WaterModel? glasses;
  final bool isSaved;
  final Status status;
}
