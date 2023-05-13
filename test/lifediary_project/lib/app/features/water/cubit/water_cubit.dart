import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:meta/meta.dart';

part 'water_state.dart';

class WaterCubit extends Cubit<WaterState> {
  WaterCubit(this._itemsRepository)
      : super(
          WaterState(
            glasses: '',
          ),
        );

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _itemsRepository.getGlassesStream().listen(
      (glasses) {
        emit(WaterState(glasses: glasses.toString()));
      },
    );
    // )..onError((error) {
    //     emit(DailyPlanState(errorMessage: error));
    //   });
  }

  Future<void> saveGlasses(String glasses) async {
    try {
      await _itemsRepository.saveGlasses(glasses);
      // final glass = await _itemsRepository.getGlasses(id: id);
      emit(
        WaterState(glasses: glasses, isSaved: true),
      );
    } catch (error) {}
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
