part of 'training_cubit.dart';

class TrainingState {

  TrainingState({
    this.items = const [],
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
    this.maxdiary = 4,
  });
  final List<ItemModel> items;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;
  int maxdiary = 4;
}

