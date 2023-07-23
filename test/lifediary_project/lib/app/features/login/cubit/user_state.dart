import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  factory UserState({
    UserModel? userModel,
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(false) bool isSaved,
  }) = _UserState;
}


// @immutable
// class UserState {
//   final UserModel? userModel;
//   final Status status;
//   final String errorMessage;
//   final bool isSaved;

//   UserState({
//     required this.userModel,
//     this.status = Status.initial,
//     required this.isSaved,
//     this.errorMessage = '',
//   });
// }
