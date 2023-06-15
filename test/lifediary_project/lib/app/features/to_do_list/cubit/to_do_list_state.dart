part of 'to_do_list_cubit.dart';

@immutable
class ToDoListState {
  final List<ItemModelToDoList> documents;
  final Status status;
  final String? errorMessage;
  final bool saved;
  final bool isChecked;

  const ToDoListState({
    this.documents = const [],
    this.status = Status.initial,
    this.errorMessage,
    this.saved = false,
    this.isChecked = false,
  });
}
