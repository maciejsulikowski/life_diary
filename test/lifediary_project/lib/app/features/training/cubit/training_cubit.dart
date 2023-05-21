import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:meta/meta.dart';

part 'training_state.dart';

class TrainingCubit extends Cubit<TrainingState> {
  TrainingCubit(this._itemsRepository) : super(TrainingState());

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _itemsRepository.getPhotosStream().listen(
      (photos) {
        emit(TrainingState(photos: photos));
      },
    )..onError(
        (error) {
          emit(TrainingState(loadingErrorOccured: true));
        },
      );
  }

  Future<void> getPhotoWithID(String id) async {
    final photoModel = await _itemsRepository.getphotos(id: id);
    emit(
      TrainingState(
        photoModel: photoModel,
      ),
    );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _itemsRepository.deletephoto(id: documentID);
    } catch (error) {
      emit(
        TrainingState(removingErrorOccured: true),
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
