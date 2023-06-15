import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:meta/meta.dart';

part 'details_photo_state.dart';

class DetailsPhotoCubit extends Cubit<DetailsPhotoState> {
  DetailsPhotoCubit(this._photosRepository)
      : super(
          const DetailsPhotoState(
            photoModel: null,
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
        photoModel: photoModel,
        status: Status.loading,
        errorMessage: '',
        isSaved: false,
      ),
    );
  }

  Future<void> start() async {
    _streamSubscription =
        _photosRepository.getPhotosStream().listen((photoModel) {
      emit(
       const DetailsPhotoState(
          photoModel: null,
          status: Status.loading,
          errorMessage: '',
          isSaved: false,
        ),
      );
    })
          ..onError((error) {
            emit(DetailsPhotoState(status: Status.error, errorMessage: error.toString(),),);
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
          photoModel: photosModel,
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
