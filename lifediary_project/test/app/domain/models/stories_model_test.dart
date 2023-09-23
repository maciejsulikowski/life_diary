import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';

void main() {
  test('should create an instance of StoriesModel from JSON', () {
    final json = {
      'author_id': 1,
      'bio': 'bio',
      'picture': 'picture',
      'source': 'source',
    };

    final quotesModel = StoriesModel.fromJson(json);

    expect(quotesModel, isA<StoriesModel>());
    expect(quotesModel.authorId, equals(1));
    expect(quotesModel.bio, equals('bio'));
    expect(quotesModel.picture, equals('picture'));
    expect(quotesModel.source, equals('source'));
  });

  test('should throw an excepction when JSON has invalid data', () {
    final json = {
      'content': 'content',
    };

    expect(() => StoriesModel.fromJson(json), throwsA(isA<Error>()));
  });

  test('should check inequality if different QuotesModel instances', () {
    final storiesModel1 = StoriesModel(1, 'bio1', 'picture1', 'source1');
    final storiesModel2 = StoriesModel(2, 'bio2', 'picture2', 'source2');

    expect(storiesModel1, isNot(equals(storiesModel2)));
  });
}
