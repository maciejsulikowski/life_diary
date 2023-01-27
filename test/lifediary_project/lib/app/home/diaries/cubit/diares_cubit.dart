import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lifediary_project/app/home/diaries/cubit/diares_cubit.dart';
import 'package:meta/meta.dart';

part 'diares_state.dart';

class DiaresCubit extends Cubit<DiaresState> {
  DiaresCubit() : super(DiaresState());

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('items')
        .orderBy('release_date')
        .snapshots()
        .listen(
      (items) {
        emit(DiaresState(items: items));
      },
    )..onError(
        (error) {
          emit(DiaresState(loadingErrorOccured: true));
        },
      );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('items')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(
        DiaresState(removingErrorOccured: true),
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
