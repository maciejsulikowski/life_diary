import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';

part 'training_state.freezed.dart';


@freezed
class TrainingState with _$TrainingState {
  factory TrainingState(
   { PhotosModel? photosModel,
    @Default([]) List<PhotosModel> photos,
    @Default(Status.initial) Status status,
    @Default(false) bool loadingErrorOccured,
    @Default(false) bool removingErrorOccured}) = _TrainingState;
}

// class TrainingState {

//   TrainingState({
//     this.photoModel,
//     this.photos = const [],
//     this.loadingErrorOccured = false,
//     this.removingErrorOccured = false,
   
//   });

//   final PhotosModel? photoModel;
//   final List<PhotosModel> photos;
//   final bool loadingErrorOccured;
//   final bool removingErrorOccured;

// }

