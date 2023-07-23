import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/quotes_model.dart';

part 'quotes_state.freezed.dart';

@freezed
class QuotesState with _$QuotesState {
  factory QuotesState({
    @Default([]) List<QuotesModel> quotes,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _QuotesState;
}

// @immutable
// class QuotesState {
//   const QuotesState({
//     this.quotes = const [],
//     this.status = Status.initial,
//     this.errorMessage,
//   });

//   final List<QuotesModel> quotes;
//   final Status status;
//   final String? errorMessage;
// }
