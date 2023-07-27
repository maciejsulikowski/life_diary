import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/features/diaries/cubit/diares_state.dart';

class DiaresCubit extends Cubit<DiaresState> {
  DiaresCubit(this._itemsRepository)
      : super(
          DiaresState(),
        );

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      DiaresState(
        status: Status.loading,
      ),
    );
    _streamSubscription = _itemsRepository.getItemsStream().listen(
      (items) {
        emit(DiaresState(items: items, status: Status.success));
      },
    )..onError(
        (error) {
          emit(
            DiaresState(
              status: Status.error,
              errorMessage: error.toString(),
            ),
          );
        },
      );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _itemsRepository.delete(id: documentID);
    } catch (error) {
      emit(
        DiaresState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
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
