part of 'water_cubit.dart';

@immutable
class WaterState {
  WaterState({
    required this.glasses,
    this.isSaved = false,
  });

  final String? glasses;
  final bool isSaved;
}
