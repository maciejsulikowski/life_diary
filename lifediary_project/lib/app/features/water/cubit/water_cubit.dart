import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/domain/repositories/water_repository.dart';
import 'package:lifediary_project/app/features/water/cubit/water_state.dart';

class WaterCubit extends Cubit<WaterState> {
  WaterCubit(this._waterRepository)
      : super(WaterState(glasses: WaterModel(id: '', glasses: '')));

  final WaterRepository _waterRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(WaterState(
      status: Status.loading,
    ));
    _streamSubscription = _waterRepository.getGlassesStream().listen(
      (glasses) {
        emit(WaterState(
          glasses: glasses,
          status: Status.success,
        ));
      },
    )..onError((error) {
        emit(
          WaterState(status: Status.error),
        );
      });
  }

  Future<void> saveGlasses(String glasses) async {
    try {
      await _waterRepository.saveGlasses(glasses);
      emit(
        WaterState(glasses: WaterModel(id: '', glasses: ''), isSaved: true),
      );
    } catch (error) {
      emit(
        WaterState(status: Status.error, glasses: null, ),
      );
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
