import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lifediary_project/app/home/diaries/cubit/diares_cubit.dart';
import 'package:lifediary_project/app/models/item_model.dart';
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
        final itemModels = items.docs.map((doc) {
          return ItemModel(
            id: doc.id,
            title: doc['title'],
            imageURL: doc['image_url'],
            releaseDate: (doc['release_date'] as Timestamp).toDate(),
          );
        }).toList();
        emit(DiaresState(items: itemModels));
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
