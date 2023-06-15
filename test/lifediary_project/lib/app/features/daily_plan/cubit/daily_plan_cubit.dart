import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/plans_repository.dart';
import 'package:meta/meta.dart';

part 'daily_plan_state.dart';

class DailyPlanCubit extends Cubit<DailyPlanState> {
  DailyPlanCubit(this._plansRepository)
      : super(DailyPlanState(
          status: Status.loading,
        ));

  final PlansRepository _plansRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _plansRepository.getDailyPlansStream().listen(
      (list) {
        emit(DailyPlanState(
          list: list,
          status: Status.success,
          saved: false,
        ));
      },
    )..onError((error) {
        emit(DailyPlanState(
            status: Status.error, errorMessage: error.toString()));
      });
  }

  Future<void> addplan(
    String title,
    String time,
  ) async {
    try {
      await _plansRepository.addplan(title, time);

      emit(
        DailyPlanState(status: Status.success, saved: true),
      );
    } catch (error) {
      emit(
          DailyPlanState(status: Status.error, errorMessage: error.toString()));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
