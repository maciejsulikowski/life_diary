
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';

part 'diares_state.freezed.dart';

@freezed
class DiaresState with _$DiaresState {
  factory DiaresState({
    @Default([]) List<ItemModel> items,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _DiaresState;
}

// @immutable
// class DiaresState {
//   DiaresState({
//     this.items = const [],
//     this.status = Status.initial,
//     this.errorMessage = '',
//   });
//   final List<ItemModel> items;
//   final Status status;
//   final String? errorMessage;
// }
