part of 'restaurants_cubit.dart';

@immutable
class RestaurantsState {
  final List<ItemModel> documents;
  final bool isLoading;
  final String errorMessage;

  const RestaurantsState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
