part of 'training_cubit.dart';

class TrainingState {

  TrainingState({
    this.photoModel,
    this.photos = const [],
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
   
  });

  final PhotosModel? photoModel;
  final List<PhotosModel> photos;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

}

