part of 'details_photo_cubit.dart';

@immutable
class DetailsPhotoState {
  const DetailsPhotoState({
    this.photoModel,
    this.isLoading = false,
    this.errorMessage = '',
    this.isSaved = false,
  });

  final PhotosModel? photoModel;
  final bool isLoading;
  final String errorMessage;
  final bool isSaved;
}
