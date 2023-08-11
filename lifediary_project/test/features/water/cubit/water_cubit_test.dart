import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/domain/repositories/water_repository.dart';
import 'package:lifediary_project/app/features/water/cubit/water_cubit.dart';
import 'package:lifediary_project/app/features/water/cubit/water_state.dart';
import 'package:mocktail/mocktail.dart';

class MockWaterRepository extends Mock implements WaterRepository {}

void main() {
  late MockWaterRepository repository;
  late WaterCubit sut;

  setUp(() {
    repository = MockWaterRepository();
    sut = WaterCubit(repository);
  });

  group('start', () {
    final model = WaterModel(
      id: '1',
      glasses: '7',
    );

    group('success', () {
      setUp(() {
        when(() => repository.getGlassesStream()).thenAnswer(
          (_) => Stream.fromIterable(
            [
              model,
            ],
          ),
        );
      });

      blocTest<WaterCubit, WaterState>(
          'emits Status.loading then Status.succes with glasses',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                WaterState(
                  status: Status.loading,
                ),
                WaterState(
                  status: Status.success,
                  glasses: model,
                ),
              ]);
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getGlassesStream()).thenAnswer((_) => Stream
            .error(Exception('test-exception-error')));
      });

      blocTest<WaterCubit, WaterState>('emits Status.loading then Status.error',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                WaterState(
                  status: Status.loading,
                ),
                WaterState(
                  status: Status.error,
                ),
              ]);
    });
  });

  group('saveGlasses', () {
    final model = WaterModel(
      id: '1',
      glasses: '7',
    );

    group('success', () {
      setUp(() {
        when(() => repository.saveGlasses('7')).thenAnswer(
          (_) => Future.value([model]),
        );
      });

      blocTest<WaterCubit, WaterState>(
          'emits Status.loading then Status.succes with glasses',
          build: () => sut,
          act: (cubit) => cubit.saveGlasses('7'),
          expect: () => [
                WaterState(
                  status: Status.loading,
                ),
                WaterState(
                  status: Status.success,
                  glasses: (model),
                  isSaved: true,
                ),
              ]);
    });

    group('failure', () {
      setUp(() {
        when(() => repository.saveGlasses('7'))
            .thenThrow((_) async => Exception('test-exception-error'));
      });

      blocTest<WaterCubit, WaterState>('emits Status.loading then Status.error',
          build: () => sut,
          act: (cubit) => cubit.saveGlasses('7'),
          expect: () => [
                WaterState(
                  status: Status.loading,
                ),
                WaterState(
                  status: Status.error,
                ),
              ]);
    });
  });
}
