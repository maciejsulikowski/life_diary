part of 'details_photo_cubit.dart';

@immutable
class DetailsPhotoState {
  const DetailsPhotoState({
    required this.photoModel,
    required this.isLoading,
    required this.errorMessage,
  });

  final PhotosModel? photoModel;
  final bool isLoading;
  final String errorMessage;
}
