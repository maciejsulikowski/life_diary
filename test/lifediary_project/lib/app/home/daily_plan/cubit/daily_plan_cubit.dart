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

  Future<void> start() async {
    _streamSubscription = _itemsRepository.getDailyPlansStream().listen(
      (list) {
        emit(DailyPlanState(list: list));
      },
    )..onError((error) {
        emit(DailyPlanState(errorMessage: error));
      });
  }

  Future<void> addplan(
    String text,
  ) async {
    try {
      await _itemsRepository.addplan(text);
      emit(
        DailyPlanState(errorMessage: ''),
      );
    } catch (error) {
      emit(DailyPlanState(errorMessage: error.toString()));
    }
  }

  Future<void> updatePlan(String text, int index) async {
    try {
      await _itemsRepository.updatePlan(text, index);
      emit(DailyPlanState(saved: true, errorMessage: ''));
    } catch (error) {
      emit(DailyPlanState(saved: false, errorMessage: error.toString()));
    }
  }

  Future<void> getplan() async {
    try {
      await _itemsRepository.getDailyPlansStream();
      emit(
        DailyPlanState(errorMessage: ''),
      );
    } catch (error) {
      emit(DailyPlanState(errorMessage: 'error'));
    }
  }
}
