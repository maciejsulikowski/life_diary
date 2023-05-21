import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/water_repository.dart';
import 'package:meta/meta.dart';

part 'water_state.dart';

class WaterCubit extends Cubit<WaterState> {
  WaterCubit(this._waterRepository)
      : super(WaterState(glasses: WaterModel(id: '', glasses: '')));

  final WaterRepository _waterRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _waterRepository.getGlassesStream().listen(
      (glasses) {
        emit(WaterState(glasses: glasses));
      },
    );
  }

  Future<void> saveGlasses(String glasses) async {
    try {
      await _waterRepository.saveGlasses(glasses);
      // final glass = await _itemsRepository.getGlasses(id: id);
      emit(
        WaterState(glasses: WaterModel(id: '', glasses: ''), isSaved: true),
      );
    } catch (error) {}
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
