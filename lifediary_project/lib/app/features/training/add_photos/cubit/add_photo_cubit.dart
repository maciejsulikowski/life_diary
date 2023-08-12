import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:lifediary_project/app/features/training/add_photos/cubit/add_photo_state.dart';

class AddPhotoCubit extends Cubit<AddPhotoState> {
  AddPhotoCubit(this._photosRepository) : super(AddPhotoState());

  final PhotosRepository _photosRepository;

  Future<void> addphoto(
    String title,
    String imageURL,
    DateTime releaseDate,
    String weight,
    String height,
    String goals,
  ) async {
    emit(AddPhotoState(status: Status.loading));
    try {
      await _photosRepository.addphoto(
          title, imageURL, releaseDate, weight, height, goals);
      emit(
        AddPhotoState(saved: true, status: Status.success),
      );
    } catch (error) {
      emit(AddPhotoState(errorMessage: error.toString(), status: Status.error));
    }
  }

  Future<Reference> pathRef() async {
    return await _photosRepository.pathRef();
  }
}
