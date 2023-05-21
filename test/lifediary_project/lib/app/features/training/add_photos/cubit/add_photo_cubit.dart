import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:meta/meta.dart';

part 'add_photo_state.dart';

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
        const AddPhotoState(saved: true),
      );
    } catch (error) {
      emit(AddPhotoState(errorMessage: error.toString()));
    }
  }
}
