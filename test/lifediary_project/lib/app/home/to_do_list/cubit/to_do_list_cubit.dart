import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifediary_project/app/models/item_model.dart';
import 'package:lifediary_project/app/repositories/items_repository.dart';
import 'package:meta/meta.dart';

part 'to_do_list_state.dart';

class ToDoListCubit extends Cubit<ToDoListState> {
  ToDoListCubit(this._itemsRepository) : super(ToDoListState());

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _itemsRepository.getTasksStream().listen(
      (documents) {
        emit(ToDoListState(documents: documents));
      },
    )..onError(
        (error) {
          emit(ToDoListState(errorMessage: 'error'));
        },
      );
  }

  Future<void> addtask(
    String title,
  ) async {
    try {
      await _itemsRepository.addtask(title);
      emit(
        const ToDoListState(saved: true),
      );
    } catch (error) {
      emit(ToDoListState(errorMessage: error.toString()));
    }
  }

  Future<void> gettask(
  ) async {
    try {
      await _itemsRepository.getTasksStream();
      emit(
        const ToDoListState(saved: true),
      );
    } catch (error) {
      emit(ToDoListState(errorMessage: error.toString()));
    }
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _itemsRepository.deletetask(id: documentID);
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
