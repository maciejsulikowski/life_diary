part of 'all_things_cubit.dart';

@immutable
class AllThingsState {
  AllThingsState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });

  final List<ItemModel> documents;
  final bool isLoading;
  final String errorMessage;
}
