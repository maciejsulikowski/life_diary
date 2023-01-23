part of 'to_do_list_cubit.dart';

@immutable
class ToDoListState {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final bool isLoading;
  final String errorMessage;

  const ToDoListState(
      {required this.documents,
      required this.isLoading,
      required this.errorMessage});
}
