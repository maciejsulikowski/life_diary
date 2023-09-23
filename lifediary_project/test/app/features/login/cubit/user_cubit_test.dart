import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:lifediary_project/app/features/login/cubit/user_cubit.dart';
import 'package:lifediary_project/app/features/login/cubit/user_state.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockStreamSubscription extends Mock implements StreamSubscription {}

class MockReference extends Mock implements Reference {}

void main() {
  late MockUserRepository repository;
  late UserCubit sut;
  late MockStreamSubscription streamSubscription;
  late MockReference reference;

  setUp(() {
    repository = MockUserRepository();
    sut = UserCubit(repository);
    streamSubscription = MockStreamSubscription();
    reference = MockReference();
  });

  group('start', () {
    final userModel = UserModel(
      id: '1',
      imageURL: 'imageURL',
      storyText: 'storyText',
      fullName: 'fullName',
    );
    group('success', () {
      setUp(() {
        when(() => repository.getUserData()).thenAnswer(
          (_) => Stream.fromIterable([
            userModel,
          ]),
        );
      });
      blocTest('should emit Status.loading then Status.succes with userModel',
          build: () => sut,
          act: (cubit) => sut.start(),
          expect: () => [
                UserState(
                  status: Status.loading,
                ),
                UserState(
                  status: Status.success,
                  userModel: userModel,
                )
              ]);
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getUserData()).thenAnswer(
          (_) => Stream.error(Exception('test-exception-error')),
        );
      });
      blocTest<UserCubit, UserState>(
          'should emit Status.loading then Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => sut.start(),
          expect: () => [
                UserState(
                  status: Status.loading,
                ),
                UserState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                  isSaved: false,
                )
              ]);
    });
  });

  group('add', () {
    final userModel = UserModel(
      id: '1',
      imageURL: 'imageURL',
      storyText: 'storyText',
      fullName: 'fullName',
    );
    group('success', () {
      setUp(() {
        when(() => repository.add('imageURL')).thenAnswer(
          (_) async => [],
        );
      });
      blocTest('should emit Status.success after calling add method',
          build: () => sut,
          act: (cubit) => sut.add('imageURL'),
          expect: () => [
                UserState(
                  status: Status.success,
                  isSaved: true,
                )
              ]);
    });

    group('failure', () {
      setUp(() {
        when(() => repository.add('imageURL'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<UserCubit, UserState>(
          'should emit Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => sut.add('imageURL'),
          expect: () => [
                UserState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                )
              ]);
    });
  });

  group('addStoryText', () {
    group('success', () {
      setUp(() {
        when(() => repository.addStoryText('storyText')).thenAnswer(
          (_) async => [],
        );
      });
      blocTest('should emit Status.success after calling addFullName method',
          build: () => sut,
          act: (cubit) => sut.addStoryText('storyText'),
          expect: () => [
                UserState(
                  status: Status.success,
                  isSaved: true,
                )
              ]);
    });

    group('failure', () {
      setUp(() {
        when(() => repository.addStoryText('storyText'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<UserCubit, UserState>(
          'should emit Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => sut.addStoryText('storyText'),
          expect: () => [
                UserState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                )
              ]);
    });
  });

  group('addFullName', () {
    group('success', () {
      setUp(() {
        when(() => repository.addFullName('fullName')).thenAnswer(
          (_) async => [],
        );
      });
      blocTest('should emit Status.success after calling addFullName method',
          build: () => sut,
          act: (cubit) => sut.addFullName('fullName'),
          expect: () => [
                UserState(
                  status: Status.success,
                  isSaved: true,
                )
              ]);
    });

    group('failure', () {
      setUp(() {
        when(() => repository.addFullName('fullName'))
            .thenThrow(Exception('test-exception-error'));
      });
      blocTest<UserCubit, UserState>(
          'should emit Status.error with errorMessage',
          build: () => sut,
          act: (cubit) => sut.addFullName('fullName'),
          expect: () => [
                UserState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                )
              ]);
    });
  });

  group('pathRef', () {
    test('pathRef is called once', () async {
      when(() => repository.pathRef()).thenAnswer((_) async => reference);
      await sut.pathRef();
      verify((() => repository.pathRef())).called(1);
    });
  });

  group('close', () {
    test('close cancels the stream subscription', () async {
      when(() => streamSubscription.cancel()).thenAnswer(
        (_) async => {},
      );

      await sut.close;

      verifyNever(() => streamSubscription.cancel()).called(0);
    });
  });
}
