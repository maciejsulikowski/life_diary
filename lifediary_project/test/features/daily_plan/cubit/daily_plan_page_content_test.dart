import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';
import 'package:lifediary_project/app/domain/repositories/plans_repository.dart';
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_cubit.dart';
import 'package:lifediary_project/app/features/daily_plan/cubit/daily_plan_state.dart';
import 'package:mocktail/mocktail.dart';

class MockPlansRepository extends Mock implements PlansRepository {}

class MockStreamSubscription extends Mock implements StreamSubscription {}

void main() {
  late MockPlansRepository repository;
  late DailyPlanCubit sut;
  late MockStreamSubscription subscription;

  setUp(() {
    repository = MockPlansRepository();
    sut = DailyPlanCubit(repository);
    subscription = MockStreamSubscription();
  });

  group('start', () {
    final model = DailyPlanModel(id: '1', time: 'time');

    group('success', () {
      setUp(() {
        when(() => repository.getDailyPlansStream())
            .thenAnswer((_) => Stream.fromIterable([
                  [model]
                ]));
      });
      blocTest<DailyPlanCubit, DailyPlanState>(
        'emits Status.loading then Status.succes with list',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          DailyPlanState(
            status: Status.loading,
            
          ),
          DailyPlanState(
            list: [model],
            status: Status.success,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getDailyPlansStream())
            .thenAnswer((_) => Stream.error(Exception('test-exception-error')));
      });
      blocTest<DailyPlanCubit, DailyPlanState>(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          DailyPlanState(
            status: Status.loading,
          ),
          DailyPlanState(
            errorMessage: 'Exception: test-exception-error',
            status: Status.error,
          ),
        ],
      );
    });
  });

  group('addplan', () {
   final model = DailyPlanModel(id: '1', time: 'time');

    group('success', () {
      setUp(() {
        when(() => repository.addplan('1', 'time')).thenAnswer(
          (_) async => [model],
        );
       
      });

      blocTest<DailyPlanCubit, DailyPlanState>(
        'emits Status loading then Status.success with photoModel',
        build: () => sut,
        act: (cubit) => cubit.addplan('1', 'time'),
        expect: () => [
          DailyPlanState(
            status: Status.loading,
          ),
          DailyPlanState(
            status: Status.success,
            isSaved: true,
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.addplan('1', 'time'))
            .thenThrow((Exception('test-exception-error')));
      });

      blocTest<DailyPlanCubit, DailyPlanState>(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => cubit.addplan('1', 'time'),
        expect: () => [
          DailyPlanState(status: Status.loading),
          DailyPlanState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });
  });
  test('close cancels the stream subscription', () {
    when(() => repository.getDailyPlansStream()).thenAnswer(
      (_) => const Stream.empty(),
    );
    when(() => subscription.cancel()).thenAnswer((_) async {});

    sut.start();
    sut.close();

    verifyNever(() => subscription.cancel()).called(0);
  });
}
