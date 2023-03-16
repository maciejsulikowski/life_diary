import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:meta/meta.dart';

part 'add_photo_state.dart';

class AddPhotoCubit extends Cubit<AddPhotoState> {
  AddPhotoCubit(this._itemsRepository) : super(AddPhotoState());

  final ItemsRepository _itemsRepository;

  Future<void> addphoto(
    String title,
    String imageURL,
    DateTime releaseDate,
    
  ) async {
    try {
      await _itemsRepository.addphoto(title, imageURL, releaseDate);
      emit(
        const AddPhotoState(saved: true),
      );
    } catch (error) {
      emit(AddPhotoState(errorMessage: error.toString()));
    }
  }
}
