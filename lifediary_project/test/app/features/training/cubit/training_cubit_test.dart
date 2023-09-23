import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:lifediary_project/app/features/training/cubit/training_cubit.dart';
import 'package:lifediary_project/app/features/training/cubit/training_state.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotosRepository extends Mock implements PhotosRepository {}

class MockStreamSubscription extends Mock implements StreamSubscription {}

void main() {
  late MockPhotosRepository repository;
  late TrainingCubit sut;
  late MockStreamSubscription subscription;

  setUp(() {
    repository = MockPhotosRepository();
    sut = TrainingCubit(repository);
    subscription = MockStreamSubscription();
  });

  group('getPhotoWithID', () {
    final model = PhotosModel(
      id: '1',
      title: 'title',
      imageURL: 'imageURL',
      releaseDate: DateTime(2023, 7, 6),
      weight: 'weight',
      height: 'height',
      goals: 'goals',
    );

    group('success', () {
      setUp(() {
        when(() => repository.getphotos(id: '1')).thenAnswer(
          (_) async => model,
        );
      });

      blocTest<TrainingCubit, TrainingState>(
        'emits Status loading then Status.success with photoModel',
        build: () => sut,
        act: (cubit) => cubit.getPhotoWithID('1'),
        expect: () => [
          TrainingState(
            status: Status.loading,
          ),
          TrainingState(
            photosModel: model,
            status: Status.success,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getphotos(id: '1'))
            .thenAnswer((_) async => throw Exception('test-error-exception'));
      });

      blocTest<TrainingCubit, TrainingState>(
        'emits Status loading then Status.error with removingErrorOccured equals true',
        build: () => sut,
        act: (cubit) => cubit.getPhotoWithID('1'),
        expect: () => [
          TrainingState(
            status: Status.loading,
          ),
          TrainingState(
            status: Status.error,
            removingErrorOccured: true,
          ),
        ],
      );
    });
  });
  group('start', () {
    final model = PhotosModel(
      id: '1',
      title: 'title',
      imageURL: 'imageURL',
      releaseDate: DateTime(2023, 7, 6),
    );

    group('success', () {
      setUp(() {
        when(() => repository.getPhotosStream())
            .thenAnswer((_) => Stream.fromIterable([
                  [model]
                ]));
      });
      blocTest<TrainingCubit, TrainingState>(
        'emits Status.loading then Status.succes with photos',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          TrainingState(
            status: Status.loading,
          ),
          TrainingState(
            status: Status.success,
            photos: [model],
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getPhotosStream())
            .thenAnswer((_) => Stream.error(Exception('test-exception-error')));
      });
      blocTest<TrainingCubit, TrainingState>(
        'emits Status.loading then Status.error with loadingErrorOccured',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          TrainingState(
            status: Status.loading,
          ),
          TrainingState(
            loadingErrorOccured: true,
            status: Status.error,
          ),
        ],
      );
    });
  });

  group('remove', () {
    group('failure', () {
      setUp(() {
        when(() => repository.deletephoto(id: '1'))
            .thenThrow(Exception('test-exception-error'));
      });

      blocTest<TrainingCubit, TrainingState>(
          'emits Status.loading then Status.error with removingErrorOccured',
          build: () => sut,
          act: (cubit) => cubit.remove(documentID: '1'),
          expect: () => [
                TrainingState(status: Status.loading),
                TrainingState(
                  status: Status.error,
                  removingErrorOccured: true,
                ),
              ]);
    });
  });
  test('close cancels the stream subscription', () {
    when(() => repository.getPhotosStream()).thenAnswer(
      (_) => const Stream.empty(),
    );
    when(() => subscription.cancel()).thenAnswer((_) async {});

    sut.start();
    sut.close();

    verifyNever(() => subscription.cancel()).called(0);
  });
}
