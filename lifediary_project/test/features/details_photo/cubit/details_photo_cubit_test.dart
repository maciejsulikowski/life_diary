import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:lifediary_project/app/domain/repositories/tasks_repository.dart';
import 'package:lifediary_project/app/features/details_photo/cubit/details_photo_cubit.dart';
import 'package:lifediary_project/app/features/details_photo/cubit/details_photo_state.dart';
import 'package:lifediary_project/app/features/to_do_list/cubit/to_do_list_cubit.dart';
import 'package:lifediary_project/app/features/to_do_list/cubit/to_do_list_state.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotosRepository extends Mock implements PhotosRepository {}

class MockStreamSubscription extends Mock implements StreamSubscription {}

void main() {
  late MockPhotosRepository repository;
  late DetailsPhotoCubit sut;
  late MockStreamSubscription subscription;

  setUp(() {
    repository = MockPhotosRepository();
    sut = DetailsPhotoCubit(repository);
    subscription = MockStreamSubscription();
  });

  group('getPhotosID', () {
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
        when(() => repository.getphotos(id: '1'))
            .thenAnswer(
          (_) async => model,
        );
        
      });

      blocTest<DetailsPhotoCubit, DetailsPhotoState>(
        'emits Status loading then Status.success with photoModel',
        build: () => sut,
        act: (cubit) => cubit.getPhotosID('1'),
        expect: () => [
          DetailsPhotoState(
            status: Status.loading,
          ),
          DetailsPhotoState(
            photosModel: model,
            status: Status.success,
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
      blocTest<DetailsPhotoCubit, DetailsPhotoState>(
        'emits Status.loading then Status.succes with documents',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          DetailsPhotoState(
            status: Status.loading,
          ),
          DetailsPhotoState(
            status: Status.success,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getPhotosStream())
            .thenAnswer((_) => Stream.error(Exception('test-exception-error')));
      });
      blocTest<DetailsPhotoCubit, DetailsPhotoState>(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          DetailsPhotoState(
            status: Status.loading,
          ),
          DetailsPhotoState(
            errorMessage: 'Exception: test-exception-error',
            status: Status.error,
          ),
        ],
      );
    });
  });

  group('savePhotoData', () {
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
        when(() => repository.savePhotoData('1', 'weight', 'height', 'goals'))
            .thenAnswer(
          (_) async => [model],
        );
        when(() => repository.getphotos(id: '1')).thenAnswer(
          (_) async => model,
        );
      });

      blocTest<DetailsPhotoCubit, DetailsPhotoState>(
        'emits Status loading then Status.success with photoModel',
        build: () => sut,
        act: (cubit) => cubit.savePhotoData('1', 'weight', 'height', 'goals'),
        expect: () => [
          DetailsPhotoState(
            status: Status.loading,
          ),
          DetailsPhotoState(
            photosModel: model,
            status: Status.success,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.savePhotoData('1', 'weight', 'height', 'goals'))
            .thenThrow(Exception('test-exception-error'));
      });

      blocTest<DetailsPhotoCubit, DetailsPhotoState>(
          'emits Status.loading then Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.savePhotoData('1', 'weight', 'height', 'goals'),
          expect: () => [
                DetailsPhotoState(status: Status.loading),
                DetailsPhotoState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
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
