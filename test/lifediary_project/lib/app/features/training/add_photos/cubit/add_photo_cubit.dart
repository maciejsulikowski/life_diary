import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:lifediary_project/app/features/training/add_photos/cubit/add_photo_state.dart';
import 'package:meta/meta.dart';


@injectable
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
    try {
      await _photosRepository.addphoto(
          title, imageURL, releaseDate, weight, height, goals);
      emit(
         AddPhotoState(saved: true),
      );
    } catch (error) {
      emit(AddPhotoState(errorMessage: error.toString()));
    }
  }
  Future<Reference> pathRef() async {
    return await _photosRepository.pathRef();
  }
}
