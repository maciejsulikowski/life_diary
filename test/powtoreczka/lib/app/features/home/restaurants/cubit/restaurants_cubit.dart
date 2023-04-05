import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:powtoreczka/app/models/item_model.dart';
import 'package:powtoreczka/app/repositories/items_repository.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit(this._itemsRepository)
      : super(const RestaurantsState(
          documents: [],
          errorMessage: '',
          isLoading: false,
        ));

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;



  Future<void> start() async {
    emit(
      const RestaurantsState(
        documents: [],
        errorMessage: '',
        isLoading: false,
      ),
    );

    _streamSubscription = _itemsRepository.getItemsStream().listen((data) {
      emit(
        RestaurantsState(
          documents: data,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          RestaurantsState(
            documents: [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  Future<void> remove({required String documentID}) async {
    try {
      _itemsRepository.delete(id: documentID);
    } catch (error) {
      emit(
        RestaurantsState(
          documents: [],
          isLoading: false,
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
