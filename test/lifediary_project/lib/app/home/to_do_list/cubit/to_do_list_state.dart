part of 'to_do_list_cubit.dart';

@immutable
class ToDoListState {
  final List<ItemModelToDoList> documents;
  final bool isLoading;
  final String errorMessage;
  final bool saved;

  const ToDoListState(
      {this.documents = const [],
      this.isLoading = false,
      this.errorMessage = '',
      this.saved = false});
}
