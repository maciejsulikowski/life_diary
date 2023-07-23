import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_photo_state.freezed.dart';

@freezed
class AddPhotoState with _$AddPhotoState {
  factory AddPhotoState({
    @Default(false) bool saved,
    @Default('') String errorMessage,
  }) = _AddPhotoState;
}

// class AddPhotoState {
//   const AddPhotoState({
//     this.saved = false,
//     this.errorMessage = '',
//   });

//   final bool saved;
//   final String errorMessage;
// }
