import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/data/remote_data_sources/stories_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';
import 'package:lifediary_project/app/domain/repositories/stories_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockStoriesDataSource extends Mock
    implements StoriesRemoteRetrofitDataSource {}

void main() {
  late StoriesRepository sut;
  late MockStoriesDataSource dataSource;

  setUp(() {
    dataSource = MockStoriesDataSource();
    sut = StoriesRepository(dataSource);
  });

  group('getStoriesModel', () {
    test('should call storiesRemoteDataSource.getStories() method', () async {
      //1
      when(() => dataSource.getStories()).thenAnswer((_) async => [
            StoriesModel(1, 'bio1', 'picture1', 'source1'),
            StoriesModel(2, 'bio2', 'picture2', 'source2'),
            StoriesModel(3, 'bio3', 'picture3', 'source3'),
          ]);
      //2
      await sut.getStoriesModel(1);
      //3
      verify(() => dataSource.getStories()).called(1);
    });

    test('', () async {
      //1
      when(() => dataSource.getStories()).thenAnswer((_) async => [
            StoriesModel(1, 'bio1', 'picture1', 'source1'),
            StoriesModel(2, 'bio2', 'picture2', 'source2'),
            StoriesModel(3, 'bio3', 'picture3', 'source3'),
          ]);
      //2
      final results = await sut.getStoriesModel(1);
      //3
      expect(results, [
        StoriesModel(1, 'bio1', 'picture1', 'source1'),
      ]);
    });
  });
}
