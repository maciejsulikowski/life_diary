import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/domain/models/quotes_model.dart';

void main() {
  test('should create an instance of QuotesModel from JSON', () {
    final json = {
      'id': 1,
      'content': 'content',
      'author_name': 'authorName',
      'author_id': 1,
    };

    final quotesModel = QuotesModel.fromJson(json);

    expect(quotesModel, isA<QuotesModel>());
    expect(quotesModel.id, equals(1));
    expect(quotesModel.content, equals('content'));
    expect(quotesModel.authorName, equals('authorName'));
    expect(quotesModel.authorId, equals(1));
  });

  test('should throw an excepction when JSON has invalid data', () {
    final json = {
      'content': 'content',
    };

    expect(() => QuotesModel.fromJson(json), throwsA(isA<Error>()));
  });

  test('should check inequality if different QuotesModel instances', () {
    final quotesModel1 = QuotesModel(1, 'content1', 'authorName1', 1);
    final quotesModel2 = QuotesModel(2, 'content2', 'authorName2', 2);

    expect(quotesModel1, isNot(equals(quotesModel2)));
  });
}
