import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/quotes_model.dart';
import 'package:lifediary_project/app/domain/repositories/quotes_repository.dart';
import 'package:lifediary_project/app/features/quotes/cubit/quotes_cubit.dart';
import 'package:lifediary_project/app/features/quotes/cubit/quotes_state.dart';
import 'package:mocktail/mocktail.dart';

class MockQuotesRepository extends Mock implements QuotesRepository {}

void main() {
  late QuotesCubit sut;
  late MockQuotesRepository repository;

  setUp(() {
    repository = MockQuotesRepository();
    sut = QuotesCubit(repository);
  });

  group('start', () {
    group('success', () {
      setUp(() {
        when(() => repository.getQuotesModel()).thenAnswer(
          (_) async => [
            QuotesModel(1, 'content1', 'authorName1', 1),
            QuotesModel(2, 'content2', 'authorName2', 2),
            QuotesModel(3, 'content3', 'authorName3', 3),
          ],
        );
      });
      blocTest<QuotesCubit, QuotesState>(
          'emits Status.loading then Status.success with results',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                QuotesState(
                  status: Status.loading,
                ),
                QuotesState(
                  quotes: [
                    QuotesModel(1, 'content1', 'authorName1', 1),
                    QuotesModel(2, 'content2', 'authorName2', 2),
                    QuotesModel(3, 'content3', 'authorName3', 3),
                  ],
                  status: Status.success,
                ),
              ]);
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getQuotesModel()).thenThrow(
          Exception('test-exception-error'),
        );
      });
      blocTest<QuotesCubit, QuotesState>(
          'emits Status.loading then Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                QuotesState(
                  status: Status.loading,
                ),
                QuotesState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                ),
              ]);
    });
  });
}
