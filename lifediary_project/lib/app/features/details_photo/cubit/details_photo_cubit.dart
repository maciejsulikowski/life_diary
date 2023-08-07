import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:lifediary_project/app/features/details_photo/cubit/details_photo_state.dart';

class DetailsPhotoCubit extends Cubit<DetailsPhotoState> {
  DetailsPhotoCubit(this._photosRepository)
      : super(
          DetailsPhotoState(
            photosModel: null,
            status: Status.loading,
            errorMessage: '',
            isSaved: false,
          ),
        );

  final PhotosRepository _photosRepository;

  StreamSubscription? _streamSubscription;

  Future<void> getPhotosID(String id) async {
    final photoModel = await _photosRepository.getphotos(id: id);
    emit(
      DetailsPhotoState(
        photosModel: photoModel,
        status: Status.loading,
        errorMessage: '',
        isSaved: false,
      ),
    );
  }

  Future<void> start() async {
    emit(
      DetailsPhotoState(
        status: Status.loading,
      ),
    );

    _streamSubscription =
        _photosRepository.getPhotosStream().listen((photoModel) {
     
      emit(
        DetailsPhotoState(
          photosModel: null,
          status: Status.loading,
          errorMessage: '',
          isSaved: false,
        ),
      );
    })
          ..onError((error) {
            emit(
              DetailsPhotoState(
                status: Status.error,
                errorMessage: error.toString(),
              ),
            );
          });
  }

  Future<void> savePhotoData(
    String id,
    String weight,
    String height,
    String goals,
  ) async {
    try {
      await _photosRepository.savePhotoData(id, weight, height, goals);
      final photosModel = await _photosRepository.getphotos(id: id);

      emit(
        DetailsPhotoState(
          photosModel: photosModel,
          isSaved: true,
        ),
      );
    } catch (error) {
      emit(DetailsPhotoState(
        errorMessage: error.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
