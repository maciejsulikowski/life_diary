import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'to_do_list_state.dart';

class ToDoListCubit extends Cubit<ToDoListState> {
  ToDoListCubit()
      : super(
          const ToDoListState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  Future<void> start() async {
    emit(
      const ToDoListState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    await Future.delayed(Duration(seconds: 5));

    emit(
      const ToDoListState(
        documents: [],
        errorMessage: '',
        isLoading: false,
      ),
    );
  }
}
