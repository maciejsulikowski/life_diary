import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:lifediary_project/app/domain/repositories/plans_repository.dart';
import 'package:lifediary_project/app/features/add_page/cubit/add_cubit.dart';
import 'package:lifediary_project/app/features/add_page/cubit/add_state.dart';
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_cubit.dart';
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_state.dart';
import 'package:lifediary_project/app/features/training/add_photos/cubit/add_photo_cubit.dart';
import 'package:lifediary_project/app/features/training/add_photos/cubit/add_photo_state.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotosRepository extends Mock implements PhotosRepository {}

class MockReference extends Mock implements Reference {}

void main() {
  late MockPhotosRepository repository;
  late AddPhotoCubit sut;
  late MockReference reference;

  setUp(() {
    repository = MockPhotosRepository();
    sut = AddPhotoCubit(repository);
    reference = MockReference();
  });

  group('add', () {

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
        when(() => repository.addphoto(
            'title', 'imageURL', DateTime(2023, 7, 6), 'weight', 'height', 'goals')).thenAnswer(
          (_) async => [model],
        );
      });

      blocTest<AddPhotoCubit, AddPhotoState>(
        'emits Status loading then Status.success with photoModel',
        build: () => sut,
        act: (cubit) =>
            cubit.addphoto('title', 'imageURL', DateTime(2023, 7, 6), 'weight', 'height', 'goals'),
        expect: () => [
          AddPhotoState(
            status: Status.loading,
          ),
          AddPhotoState(
            status: Status.success,
            saved: true,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.addphoto(
                'title',
            'imageURL',
            DateTime(2023, 7, 6),
            'weight',
            'height',
            'goals'))
            .thenThrow((Exception('test-exception-error')));
      });

      blocTest<AddPhotoCubit, AddPhotoState>(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) =>
            cubit.addphoto('title', 'imageURL', DateTime(2023, 7, 6),
            'weight', 'height', 'goals'),
        expect: () => [
          AddPhotoState(status: Status.loading),
          AddPhotoState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });

    group('pathRef', () {
      test('pathRef() returns a Reference', () async {
        when(() => repository.pathRef()).thenAnswer((_) async => reference);

        final result = await repository.pathRef();

        expect(result, equals(reference));
        verify(() => repository.pathRef()).called(1);
      });
    });
  });
}
