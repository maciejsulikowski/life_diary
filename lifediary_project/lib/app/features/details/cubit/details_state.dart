import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';

part 'details_state.freezed.dart';

@freezed
class DetailsState with _$DetailsState {
  factory DetailsState({
    ItemModel? itemModel,
    @Default(Status.initial) Status status,
    String? errorMessage,
    @Default(false) bool isSaved,
  }) = _DetailsState;
}

// @immutable
// class DetailsState {
//   const DetailsState({
//     required this.itemModel,
//     this.status = Status.initial,
//     this.errorMessage,
//     required this.saved,
//   });

//   final ItemModel? itemModel;
//   final Status status;
//   final String? errorMessage;
//   final bool saved;
// }
