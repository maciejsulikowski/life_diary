import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/quotes_model.dart';
import 'package:lifediary_project/app/domain/repositories/quotes_repository.dart';
import 'package:lifediary_project/app/features/quotes/cubit/quotes_state.dart';


class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit(this.quotesRepository) : super(QuotesState());

  final QuotesRepository quotesRepository;

  Future<void> start() async {
    emit(
      QuotesState(
        status: Status.loading,
      ),
    );
    try {
      final results = await quotesRepository.getQuotesModel();
      emit(
        QuotesState(
          quotes: results,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(QuotesState(
        errorMessage: error.toString(),
        status: Status.error,
      ));
    }
  }
}
