import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/features/details/cubit/details_cubit.dart';
import 'package:lifediary_project/app/features/details/cubit/details_state.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

class MockStreamSubscription extends Mock implements StreamSubscription {}

void main() {
  late MockItemsRepository repository;
  late DetailsCubit sut;
  late MockStreamSubscription subscription;

  setUp(() {
    repository = MockItemsRepository();
    sut = DetailsCubit(repository);
    subscription = MockStreamSubscription();
  });

  group('getItemWithID', () {
    final model = ItemModel(
        id: '1',
        title: 'title',
        imageURL: 'imageURL',
        releaseDate: DateTime(2023, 6, 7),
        text: []);

    group('success', () {
      setUp(() {
        when(() => repository.get(id: '1')).thenAnswer(
          (_) async => model,
        );
      });

      blocTest<DetailsCubit, DetailsState>(
        'emits Status loading then Status.success with itemModel',
        build: () => sut,
        act: (cubit) => cubit.getItemWithID('1'),
        expect: () => [
          DetailsState(
            status: Status.loading,
          ),
          DetailsState(
            itemModel: model,
            status: Status.success,
          ),
        ],
      );
    });
  });
  group('start', () {
    final model = ItemModel(
        id: '1',
        title: 'title',
        imageURL: 'imageURL',
        releaseDate: DateTime(2023, 6, 7),
        text: []);

    group('success', () {
      setUp(() {
        when(() => repository.getItemsStream())
            .thenAnswer((_) => Stream.fromIterable([
                  [model]
                ]));
      });
      blocTest<DetailsCubit, DetailsState>(
        'emits Status.loading then Status.succes with documents',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          DetailsState(
            status: Status.loading,
          ),
          DetailsState(
            status: Status.success,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getItemsStream())
            .thenAnswer((_) => Stream.error(Exception('test-exception-error')));
      });
      blocTest<DetailsCubit, DetailsState>(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          DetailsState(
            status: Status.loading,
          ),
          DetailsState(
            errorMessage: 'Exception: test-exception-error',
            status: Status.error,
          ),
        ],
      );
    });
  });

  group('addtext', () {
    final model = ItemModel(
        id: '1',
        title: 'title',
        imageURL: 'imageURL',
        releaseDate: DateTime(2023, 6, 7),
        text: []);
    final delta = Delta()..insert('Hello world!');

    group('success', () {
      setUp(() {
        when(() => repository.addtext('1', delta)).thenAnswer(
          (_) async => [model],
        );
        when(() => repository.get(id: '1')).thenAnswer(
          (_) async => model,
        );
      });

      blocTest<DetailsCubit, DetailsState>(
        'emits Status loading then Status.success with photoModel',
        build: () => sut,
        act: (cubit) => cubit.addtext('1', delta),
        expect: () => [
          DetailsState(
            status: Status.loading,
          ),
          DetailsState(
            itemModel: model,
            status: Status.success,
            isSaved: true,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.addtext('1', delta)).thenAnswer(
          (_) async => throw Exception('test-exception-error'),
        );
      });

      blocTest<DetailsCubit, DetailsState>(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.addtext('1', delta),
        expect: () => [
          DetailsState(
            status: Status.loading,
          ),
          DetailsState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });
  });
}
