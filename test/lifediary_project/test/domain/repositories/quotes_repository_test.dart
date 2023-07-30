import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/data/remote_data_sources/quotes_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/quotes_model.dart';
import 'package:lifediary_project/app/domain/repositories/quotes_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockQuotesDataSource extends Mock
    implements QuotesRemoteRetrofitDataSource {}

void main() {
  late QuotesRepository sut;
  late MockQuotesDataSource dataSource;

  setUp(() {
    dataSource = MockQuotesDataSource();
    sut = QuotesRepository(dataSource);
  });

  group('getQuotesModel', () {
    test('should call quotesRemoteDataSource.getQuotes() method', () async {
      //1
      when(() => dataSource.getQuotes()).thenAnswer((_) async => []);
      //2
      await sut.getQuotesModel();
      //3
      verify(() => (dataSource.getQuotes())).called(1);
    });

    test('', () async {
      //1
      when(() => dataSource.getQuotes()).thenAnswer((_) async => [
            QuotesModel(1, 'content1', 'authorName1', 1),
            QuotesModel(2, 'content2', 'authorName2', 2),
            QuotesModel(3, 'content3', 'authorName3', 3),
          ]);
      //2
      final results = await sut.getQuotesModel();
      //3
      expect(results, [
        QuotesModel(1, 'content1', 'authorName1', 1),
        QuotesModel(2, 'content2', 'authorName2', 2),
        QuotesModel(3, 'content3', 'authorName3', 3),
      ]);
    });
  });
}
