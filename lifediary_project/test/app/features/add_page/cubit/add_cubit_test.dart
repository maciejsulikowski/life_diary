import 'dart:async';
import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/domain/repositories/plans_repository.dart';
import 'package:lifediary_project/app/features/add_page/cubit/add_cubit.dart';
import 'package:lifediary_project/app/features/add_page/cubit/add_state.dart';
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_cubit.dart';
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_state.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

class MockReference extends Mock implements Reference {}

void main() {
  late MockItemsRepository repository;
  late AddCubit sut;
  late MockReference reference;

  setUp(() {
    repository = MockItemsRepository();
    sut = AddCubit(repository);
    reference = MockReference();
  });

  group('add', () {
    final delta = Delta()..insert('Hello world!');

    final model = ItemModel(
        id: '1',
        title: 'title',
        imageURL: 'imageURL',
        releaseDate: DateTime(2023, 7, 6),
        text: []);

    group('success', () {
      setUp(() {
        when(() => repository.add(
            'title', 'imageURL', DateTime(2023, 7, 6), delta, 1)).thenAnswer(
          (_) async => [model],
        );
      });

      blocTest<AddCubit, AddState>(
        'emits Status loading then Status.success with photoModel',
        build: () => sut,
        act: (cubit) =>
            cubit.add('title', 'imageURL', DateTime(2023, 7, 6), delta, 1),
        expect: () => [
          AddState(
            status: Status.loading,
          ),
          AddState(
            status: Status.success,
            isSaved: true,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.add(
                'title', 'imageURL', DateTime(2023, 7, 6), delta, 1))
            .thenThrow((Exception('test-exception-error')));
      });

      blocTest<AddCubit, AddState>(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) =>
            cubit.add('title', 'imageURL', DateTime(2023, 7, 6), delta, 1),
        expect: () => [
          AddState(status: Status.loading),
          AddState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });

    group('pathRef', () {
      
        test('pathRef is called once', () async {
          when(() => repository.pathRef()).thenAnswer((_) async => reference);
          await sut.pathRef();
          verify((() => repository.pathRef())).called(1);
        });
      

    });
  });
}
