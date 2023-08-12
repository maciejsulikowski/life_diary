import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/features/diaries/cubit/diares_cubit.dart';
import 'package:lifediary_project/app/features/diaries/cubit/diares_state.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

class MockStreamSubscription extends Mock implements StreamSubscription {}

void main() {
  late MockItemsRepository repository;
  late DiaresCubit sut;
  late MockStreamSubscription subscription;

  setUp(() {
    repository = MockItemsRepository();
    sut = DiaresCubit(repository);
    subscription = MockStreamSubscription();
  });

  group('start', () {
    final itemModel = ItemModel(
        id: '1',
        title: 'title',
        imageURL: 'imageURL',
        releaseDate: DateTime(2023, 7, 6),
        text: []);
    group('success', () {
      setUp(() {
        when(() => repository.getItemsStream())
            .thenAnswer((_) => Stream.fromIterable([
                  [itemModel]
                ]));
      });
      blocTest<DiaresCubit, DiaresState>(
          'emit Status.loading then Status.success',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                DiaresState(status: Status.loading),
                DiaresState(status: Status.success, items: [itemModel]),
              ]);
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getItemsStream())
            .thenAnswer((_) => Stream.error(Exception('test-exception-error')));
      });
      blocTest<DiaresCubit, DiaresState>(
          'emit Status.loading then Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                DiaresState(status: Status.loading),
                DiaresState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                ),
              ]);
    });
  });
  group('remove', () {
    group('failure', () {
      setUp(() {
        when(() => repository.delete(id: '1'))
            .thenThrow(Exception('test-exception-error'));
      });

      blocTest<DiaresCubit, DiaresState>(
          'emits  Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.remove(documentID: '1'),
          expect: () => [
                DiaresState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                ),
              ]);
    });
  });
  test('close cancels the stream subscription', () {
    when(() => repository.getItemsStream()).thenAnswer(
      (_) => const Stream.empty(),
    );
    when(() => subscription.cancel()).thenAnswer((_) async {});

    sut.start();
    sut.close();

    verifyNever(() => subscription.cancel()).called(0);
  });
}
