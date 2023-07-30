import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';
import 'package:lifediary_project/app/domain/repositories/stories_repository.dart';
import 'package:lifediary_project/app/features/stories/cubit/stories_cubit.dart';
import 'package:lifediary_project/app/features/stories/cubit/stories_state.dart';
import 'package:mocktail/mocktail.dart';

class MockStoriesRepository extends Mock implements StoriesRepository {}

void main() {
  late StoriesCubit sut;
  late MockStoriesRepository repository;

  setUp(() {
    repository = MockStoriesRepository();
    sut = StoriesCubit(repository);
  });

  group('fetchData', () {
    group('success', () {
      setUp(() {
        when(() => repository.getStoriesModel(1)).thenAnswer((_) async => [
              StoriesModel(1, 'bio1', 'picture1', 'source1'),
              StoriesModel(2, 'bio2', 'picture2', 'source2'),
              StoriesModel(3, 'bio3', 'picture3', 'source3')
            ]);
      });
      blocTest<StoriesCubit, StoriesState>(
          'emit Status.loading then Status.success with results',
          build: () => sut,
          act: (cubit) => cubit.fetchData(authorID: 1),
          expect: () => [
                StoriesState(
                  status: Status.loading,
                ),
                StoriesState(
                  stories: [
                    StoriesModel(1, 'bio1', 'picture1', 'source1'),
                    StoriesModel(2, 'bio2', 'picture2', 'source2'),
                    StoriesModel(3, 'bio3', 'picture3', 'source3')
                  ],
                  status: Status.success,
                ),
              ]);
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getStoriesModel(1))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<StoriesCubit, StoriesState>(
          'emit Status.loading then Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.fetchData(authorID: 1),
          expect: () => [
                StoriesState(
                  status: Status.loading,
                ),
                StoriesState(
                  errorMessage: 'Exception: test-exception-error',
                  status: Status.error,
                ),
              ]);
    });
  });
}
