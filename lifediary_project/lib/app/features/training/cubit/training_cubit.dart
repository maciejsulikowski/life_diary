import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:lifediary_project/app/features/training/cubit/training_state.dart';

class TrainingCubit extends Cubit<TrainingState> {
  TrainingCubit(this._photosRepository) : super(TrainingState());

  final PhotosRepository _photosRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(TrainingState(status: Status.loading));
    _streamSubscription = _photosRepository.getPhotosStream().listen(
      (photos) {
        emit(TrainingState(photos: photos, status: Status.success));
      },
    )..onError(
        (error) {
          emit(TrainingState(
            loadingErrorOccured: true,
            status: Status.error,
          ));
        },
      );
  }

  Future<void> getPhotoWithID(String id) async {
    emit(TrainingState(status: Status.loading));

    try {
      final photoModel = await _photosRepository.getphotos(id: id);
      emit(
        TrainingState(
          photosModel: photoModel,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(TrainingState(
        status: Status.error,
        removingErrorOccured: true,
      ));
    }
  }

  Future<void> remove({required String documentID}) async {
    emit(TrainingState(status: Status.loading));
    try {
      await _photosRepository.deletephoto(id: documentID);
    } catch (error) {
      emit(
        TrainingState(removingErrorOccured: true, status: Status.error),
      );
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
