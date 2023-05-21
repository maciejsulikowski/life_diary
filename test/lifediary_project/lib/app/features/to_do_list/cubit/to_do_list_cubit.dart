import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/tasks_repository.dart';
import 'package:meta/meta.dart';

part 'to_do_list_state.dart';

class ToDoListCubit extends Cubit<ToDoListState> {
  ToDoListCubit(this._tasksRepository) : super(ToDoListState());

  final TasksRepository _tasksRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _tasksRepository.getTasksStream().listen(
      (documents) {
        emit(ToDoListState(documents: documents));
      },
    )..onError(
        (error) {
          emit(
            ToDoListState(
              errorMessage: error.toString(),
            ),
          );
        },
      );
  }

  Future<void> addtask(
    String title,
    bool isChecked,
  ) async {
    try {
      await _tasksRepository.addtask(title, isChecked);
      emit(
        const ToDoListState(saved: true),
      );
    } catch (error) {
      emit(ToDoListState(errorMessage: error.toString()));
    }
  }
  
  Future<void> updateTask(ItemModelToDoList itemModel) async {
    try {
      await _tasksRepository.updateTask(itemModel);
    } catch (error) {
      emit(
        ToDoListState(errorMessage: 'Something went wrong'),
      );
    }
  }

 

  Future<void> remove({required String documentID}) async {
    try {
      await _tasksRepository.deletetask(id: documentID);
    } catch (error) {
      emit(
        ToDoListState(errorMessage: 'Something went wrong'),
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
