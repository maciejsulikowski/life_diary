import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/repositories/tasks_repository.dart';
import 'package:lifediary_project/app/features/to_do_list/cubit/to_do_list_cubit.dart';
import 'package:lifediary_project/app/features/to_do_list/cubit/to_do_list_state.dart';
import 'package:mocktail/mocktail.dart';

class MockTasksRepository extends Mock implements TasksRepository {}

class MockStreamSubscription extends Mock implements StreamSubscription {}

void main() {
  late MockTasksRepository repository;
  late ToDoListCubit sut;
  late MockStreamSubscription subscription;

  setUp(() {
    repository = MockTasksRepository();
    sut = ToDoListCubit(repository);
    subscription = MockStreamSubscription();
  });

  group('start', () {
    final model = ItemModelToDoList(id: '1', title: 'title');

    group('success', () {
      setUp(() {
        when(() => repository.getTasksStream())
            .thenAnswer((_) => Stream.fromIterable([
                  [model]
                ]));
      });
      blocTest<ToDoListCubit, ToDoListState>(
        'emits Status.loading then Status.succes with documents',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          ToDoListState(
            status: Status.loading,
          ),
          ToDoListState(
            documents: [model],
            status: Status.success,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getTasksStream())
            .thenAnswer((_) => Stream.error(Exception('test-exception-error')));
      });
      blocTest<ToDoListCubit, ToDoListState>(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          ToDoListState(
            status: Status.loading,
          ),
          ToDoListState(
            errorMessage: 'Exception: test-exception-error',
            status: Status.error,
          ),
        ],
      );
    });
  });

  group('addtask', () {
    final model = ItemModelToDoList(
      id: '1',
      title: 'title',
      isChecked: false,
    );

    group('success', () {
      setUp(() {
        when(() => repository.addtask('title', true)).thenAnswer(
          (_) => Future.value([
            [model]
          ]),
        );
      });

      blocTest<ToDoListCubit, ToDoListState>(
          'emits Status.loading then Status.succes',
          build: () => sut,
          act: (cubit) => cubit.addtask('title', true),
          expect: () => [
                ToDoListState(
                  status: Status.loading,
                ),
                ToDoListState(
                  status: Status.success,
                  saved: true,
                ),
              ]);
    });

    group('failure', () {
      setUp(() {
        when(() => repository.addtask('title', false))
            .thenThrow(Exception('test-exception-error'));
      });

      blocTest<ToDoListCubit, ToDoListState>(
          'emits Status.loading then Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.addtask('title', false),
          expect: () => [
                ToDoListState(
                  status: Status.loading,
                ),
                ToDoListState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                ),
              ]);
    });
  });

  group('updateTask', () {
    final model = ItemModelToDoList(
      id: '1',
      title: 'title',
      isChecked: false,
    );

    group('success', () {
      setUp(() {
        when(() => repository.updateTask(
              ItemModelToDoList(
                id: '1',
                title: 'title',
                isChecked: false,
              ),
            )).thenAnswer(
          (_) => Future.value([
            [model]
          ]),
        );
      });

      blocTest<ToDoListCubit, ToDoListState>('emits Status.succes',
          build: () => sut,
          act: (cubit) => cubit.updateTask(model),
          expect: () => [
                ToDoListState(
                  status: Status.success,
                ),
              ]);
    });

    group('failure', () {
      final model = ItemModelToDoList(
        id: '1',
        title: 'title',
        isChecked: false,
      );
      setUp(() {
        when(() => repository.updateTask(model))
            .thenThrow(Exception('test-exception-error'));
      });

      blocTest<ToDoListCubit, ToDoListState>(
          'emits Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.updateTask(model),
          expect: () => [
                ToDoListState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                ),
              ]);
    });
  });

  group('remove', () {
    

    group('failure', () {
      setUp(() {
        when(() => repository.deletetask(id: '1'))
            .thenThrow(Exception('test-exception-error'));
      });

      blocTest<ToDoListCubit, ToDoListState>(
          'emits  Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => cubit.remove(documentID: '1'),
          expect: () => [
                ToDoListState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                ),
              ]);
    });
  });

  test('close cancels the stream subscription', () {
    when(() => repository.getTasksStream()).thenAnswer(
      (_) => const Stream.empty(),
    );
    when(() => subscription.cancel()).thenAnswer((_) async {});

    sut.start();
    sut.close();

    verifyNever(() => subscription.cancel()).called(0);
  });
}
