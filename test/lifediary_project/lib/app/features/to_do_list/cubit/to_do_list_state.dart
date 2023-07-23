import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';

part 'to_do_list_state.freezed.dart';

@freezed
class ToDoListState with _$ToDoListState {
  factory ToDoListState({
    @Default([]) List<ItemModelToDoList> documents,
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(false) bool saved,
    @Default(false) bool isChecked,
  }) = _ToDoListState;
}

// @immutable
// class ToDoListState {
//   final List<ItemModelToDoList> documents;
//   final Status status;
//   final String? errorMessage;
//   final bool saved;
//   final bool isChecked;

//   const ToDoListState({
//     this.documents = const [],
//     this.status = Status.initial,
//     this.errorMessage,
//     this.saved = false,
//     this.isChecked = false,
//   });
// }
