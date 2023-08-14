import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/repositories/tasks_repository.dart';
import 'package:lifediary_project/app/features/to_do_list/cubit/to_do_list_state.dart';

class ToDoListCubit extends Cubit<ToDoListState> {
  ToDoListCubit(this._tasksRepository) : super(ToDoListState());

  final TasksRepository _tasksRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(ToDoListState(status: Status.loading));
    _streamSubscription = _tasksRepository.getTasksStream().listen(
      (documents) {
        emit(ToDoListState(
          documents: documents,
          status: Status.success,
        ));
      },
    )..onError(
        (error) {
          emit(
            ToDoListState(
              errorMessage: error.toString(),
              status: Status.error,
            ),
          );
        },
      );
  }

  Future<void> addtask(
    String title,
    bool isChecked,
  ) async {
    emit(ToDoListState(status: Status.loading));
    try {
      await _tasksRepository.addtask(title, isChecked);
      emit(
        ToDoListState(saved: true, status: Status.success),
      );
      start();
    } catch (error) {
      emit(ToDoListState(status: Status.error, errorMessage: error.toString()));
    }
  }

  Future<void> updateTask(ItemModelToDoList itemModel) async {
    try {
      await _tasksRepository.updateTask(itemModel);
      emit(ToDoListState(status: Status.success));
      start();
    } catch (error) {
      emit(
        ToDoListState(status: Status.error, errorMessage: error.toString()),
      );
    }
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _tasksRepository.deletetask(id: documentID);
    } catch (error) {
      emit(
        ToDoListState(status: Status.error, errorMessage: error.toString()),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
