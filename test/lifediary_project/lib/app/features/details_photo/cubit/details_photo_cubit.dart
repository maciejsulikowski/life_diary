import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:meta/meta.dart';

part 'details_photo_state.dart';

class DetailsPhotoCubit extends Cubit<DetailsPhotoState> {
  DetailsPhotoCubit(this._itemsRepository)
      : super(
          const DetailsPhotoState(
            photoModel: null,
            isLoading: true,
            errorMessage: '',
          ),
        );

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> getPhotosID(String id) async {
    final photoModel = await _itemsRepository.getphotos(id: id);
    emit(
      DetailsPhotoState(
        photoModel: photoModel,
        isLoading: false,
        errorMessage: '',
      ),
    );
  }

  Future<void> start() async {
    _streamSubscription =
        _itemsRepository.getPhotosStream().listen((photoModel) {
      emit(
        DetailsPhotoState(
          photoModel: photoModel as PhotosModel,
          isLoading: false,
          errorMessage: '',
        ),
      );
    });
  }
}
