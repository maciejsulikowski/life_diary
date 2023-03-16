import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lifediary_project/app/models/item_model.dart';
import 'package:lifediary_project/app/repositories/items_repository.dart';
import 'package:meta/meta.dart';

part 'daily_plan_state.dart';

class DailyPlanCubit extends Cubit<DailyPlanState> {
  DailyPlanCubit(this._itemsRepository) : super(DailyPlanState());

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> getPlanWithID(String id) async {
    final dailyplanmodel = await _itemsRepository.getplans(id: id);
    emit(
      DailyPlanState(list: [dailyplanmodel]),
    );
  }

  Future<void> start() async {
    _streamSubscription = _itemsRepository.getDailyPlansStream().listen(
      (list) {
        emit(DailyPlanState(
            list: list, isLoading: false, saved: false, errorMessage: ''));
      },
    )..onError((error) {
        emit(DailyPlanState(errorMessage: error));
      });
  }

  Future<void> addplan(
    String title,
    String time,
  ) async {
    try {
      await _itemsRepository.addplan(title, time);

      emit(
        DailyPlanState(saved: true),
      );
    } catch (error) {
      emit(DailyPlanState(errorMessage: error.toString()));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  getDailyPlansStream() {}
}