part of 'details_cubit.dart';

@immutable
class DetailsState {
  const DetailsState({
    required this.itemModel,
    this.status = Status.initial,
    this.errorMessage,
    required this.saved,
  });

  final ItemModel? itemModel;
  final Status status;
  final String? errorMessage;
  final bool saved;
}
