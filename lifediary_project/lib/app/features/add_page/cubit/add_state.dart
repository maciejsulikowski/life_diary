

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';

part 'add_state.freezed.dart';

@freezed
class AddState with _$AddState {
  factory AddState({
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(false) bool isSaved,
  }) = _AddState;
}

// @immutable
// class AddState {
//   const AddState({
//     this.status = Status.initial,
//     this.saved = false,
//     this.errorMessage,
//   });

//   final Status status;
//   final bool saved;
//   final String? errorMessage;
// }
