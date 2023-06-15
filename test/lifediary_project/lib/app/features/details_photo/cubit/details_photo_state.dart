part of 'details_photo_cubit.dart';

@immutable
class DetailsPhotoState {
  const DetailsPhotoState({
    this.photoModel,
    this.status = Status.initial,
    this.errorMessage = '',
    this.isSaved = false,
  });

  final PhotosModel? photoModel;
  final Status status;
  final String errorMessage;
  final bool isSaved;
}
