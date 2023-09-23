import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/cubit/root_state.dart';
import 'package:lifediary_project/app/domain/repositories/root_repository.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockStreamSubscription extends Mock implements StreamSubscription {}

class MockUser extends Mock implements User {}

class MockUserRepository extends Mock implements UserRepository {}

class MockRootRepository extends Mock implements RootRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late MockRootRepository mockRootRepository;
  late RootCubit sut;
  late MockUser user;
  late MockStreamSubscription streamSubscription;
  late TextEditingController email;
  late TextEditingController password;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockRootRepository = MockRootRepository();
    sut = RootCubit(mockUserRepository, mockRootRepository);
    user = MockUser();
    streamSubscription = MockStreamSubscription();
    email = TextEditingController(text: 'maciek@gmail.com');
    password = TextEditingController(text: '1234');
  });

  group('start', () {
    group('success', () {
      setUp(() {
        when(() => mockRootRepository.authStateChanges())
            .thenAnswer((_) => Stream.value(user));
      });

      blocTest(
        'emits Status.loading then Status.success with user',
        build: () => sut,
        act: (cubit) => sut.start(),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.success,
            user: user,
          )
        ],
      );
    });
    group('failure', () {
      setUp(() {
        when(() => mockRootRepository.authStateChanges())
            .thenAnswer((_) => Stream.error(Exception('test-user-exception')));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.start(),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Exception: test-user-exception',
          )
        ],
      );
    });
  });

  group('createAccount', () {
    group('success', () {
      setUp(() {
        when(() => mockRootRepository.createAccount(
              email: email.text,
              password: password.text,
            )).thenAnswer((_) async => []);
      });

      blocTest(
        'emits Status.loading then Status.success with user',
        build: () => sut,
        act: (cubit) => sut.createAccount(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.success,
          )
        ],
      );
    });
    group('failure - 1', () {
      String errorMessage = 'invalid-email';

      setUp(() {
        when(() => mockRootRepository.createAccount(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.createAccount(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Niepoprawny format adresu email.',
          ),
        ],
      );
    });
    group('failure - 2', () {
      String errorMessage = 'email-already-in-use';

      setUp(() {
        when(() => mockRootRepository.createAccount(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.createAccount(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Konto z tym adresem email już istnieje.',
          ),
        ],
      );
    });
    group('failure - 3', () {
      String errorMessage = 'operation-not-allowed';

      setUp(() {
        when(() => mockRootRepository.createAccount(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.createAccount(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Rejestracja z tym adresem email jest wyłączona.',
          ),
        ],
      );
    });
    group('failure - 4', () {
      String errorMessage = 'weak-password';

      setUp(() {
        when(() => mockRootRepository.createAccount(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.createAccount(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Hasło jest zbyt słabe.',
          ),
        ],
      );
    });
    group('failure - 5', () {
      String errorMessage = '';

      setUp(() {
        when(() => mockRootRepository.createAccount(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.createAccount(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Wystąpił błąd podczas rejestracji.',
          ),
        ],
      );
    });
  });

  group('signIn', () {
    group('success', () {
      setUp(() {
        when(() => mockRootRepository.signIn(
              email: email.text,
              password: password.text,
            )).thenAnswer((_) async => []);
      });

      blocTest(
        'emits Status.loading then Status.success',
        build: () => sut,
        act: (cubit) => sut.signIn(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.success,
          )
        ],
      );
    });
    group('failure - 1', () {
      String errorMessage = 'invalid-email';

      setUp(() {
        when(() => mockRootRepository.signIn(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.signIn(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Niepoprawny format adresu email.',
          ),
        ],
      );
    });
    group('failure - 2', () {
      String errorMessage = 'user-not-found';

      setUp(() {
        when(() => mockRootRepository.signIn(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.signIn(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Brak użytkownika o podanym adresie email.',
          ),
        ],
      );
    });
    group('failure - 3', () {
      String errorMessage = 'wrong-password';

      setUp(() {
        when(() => mockRootRepository.signIn(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.signIn(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Niepoprawne hasło.',
          ),
        ],
      );
    });
    group('failure - 4', () {
      String errorMessage = 'account-exists-with-different-credential';

      setUp(() {
        when(() => mockRootRepository.signIn(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.signIn(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Konto już istnieje.',
          ),
        ],
      );
    });
    group('failure - 5', () {
      String errorMessage = 'user-disabled';

      setUp(() {
        when(() => mockRootRepository.signIn(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.signIn(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Użytkownik jest wyłączony.',
          ),
        ],
      );
    });

    group('failure - 6', () {
      String errorMessage = '';

      setUp(() {
        when(() => mockRootRepository.signIn(
              email: email.text,
              password: password.text,
            )).thenThrow(FirebaseAuthException(
          code: errorMessage,
        ));
      });

      blocTest(
        'emits Status.loading then Status.error with errorMessage',
        build: () => sut,
        act: (cubit) => sut.signIn(email, password),
        expect: () => [
          RootState(
            status: Status.loading,
          ),
          RootState(
            status: Status.error,
            errorMessage: 'Wystąpił błąd logowania.',
          ),
        ],
      );
    });
  });

  group('signOut', () {
    test('signOut calls repository to sign the user out', () async {
      when(() => mockRootRepository.signOut()).thenAnswer((_) async {});
      await sut.signOut();
      verify(() => mockRootRepository.signOut()).called(1);
    });
  });
  group('addUserPhoto', () {
    test('signOut calls repository to sign the user out', () async {
      when(() => mockUserRepository.add('imageURL')).thenAnswer((_) async {});
      await sut.addUserPhoto('imageURL');
      verify(() => mockUserRepository.add('imageURL')).called(1);
    });
  });
  group('addUserPhoto', () {
    test('addUserPhoto calls repository to add photo', () async {
      when(() => mockUserRepository.add('imageURL')).thenAnswer((_) async {});
      await sut.addUserPhoto('imageURL');
      verify(() => mockUserRepository.add('imageURL')).called(1);
    });
  });

  group('close', () {
    test('close cancels the stream subscription', () async {
      when(() => streamSubscription.cancel()).thenAnswer((_) async {});

      await sut.close();

      verifyNever(() => streamSubscription.cancel()).called(0);
    });
  });
}
