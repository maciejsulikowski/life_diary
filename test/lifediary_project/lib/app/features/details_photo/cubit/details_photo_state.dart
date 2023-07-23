import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';

part 'details_photo_state.freezed.dart';

@freezed
class DetailsPhotoState with _$DetailsPhotoState {
  factory DetailsPhotoState({
    PhotosModel? photosModel,
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(false) bool isSaved,
  }) = _DetailsPhotoState;
}

// @immutable
// class DetailsPhotoState {
//   const DetailsPhotoState({
//     this.photoModel,
//     this.status = Status.initial,
//     this.errorMessage = '',
//     this.isSaved = false,
//   });

//   final PhotosModel? photoModel;
//   final Status status;
//   final String errorMessage;
//   final bool isSaved;
// }
