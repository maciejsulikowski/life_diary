part of 'quotes_cubit.dart';

@immutable
class QuotesState {
  const QuotesState({
    this.quotes = const [],
    this.status = Status.initial,
    this.errorMessage,
  });

  final List<QuotesModel> quotes;
  final Status status;
  final String? errorMessage;
}
