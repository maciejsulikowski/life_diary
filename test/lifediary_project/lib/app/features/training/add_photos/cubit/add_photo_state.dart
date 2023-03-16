part of 'add_photo_cubit.dart';

class AddPhotoState {
  const AddPhotoState({
    this.saved = false,
    this.errorMessage = '',
  });

  final bool saved;
  final String errorMessage;
}
