import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/data/remote_data_sources/root_remote_data_source.dart';
import 'package:lifediary_project/app/domain/repositories/root_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRootDataSource extends Mock implements RootRemoteDataSource {}

class MockUser extends Mock implements User {}

void main() {
  late MockRootDataSource dataSource;
  late RootRepository sut;

  setUp(() {
    dataSource = MockRootDataSource();
    sut = RootRepository(dataSource);
  });

  group('createAccount', () {
    test(
        'should call rootRemoteDataSource.createUserWithEmailAndPassword() method',
        () async {
      when(() => dataSource.createUserWithEmailAndPassword('email', 'password'))
          .thenAnswer((_) async => []);
      await sut.createAccount(email: 'email', password: 'password');
      verify(() =>
              dataSource.createUserWithEmailAndPassword('email', 'password'))
          .called(1);
    });

    test('should await createAccount() method successful', () async {
      when(() => dataSource.createUserWithEmailAndPassword('email', 'password'))
          .thenAnswer((_) async => []);
      final results =
          await sut.createAccount(email: 'email', password: 'password');
      expect(results, isA<void>());
    });
  });

  group('signIn', () {
    test('should call rootRemoteDataSource.signInWithEmailAndPassword() method',
        () async {
      when(() => dataSource.signInWithEmailAndPassword('email', 'password'))
          .thenAnswer((_) async => []);
      await sut.signIn(email: 'email', password: 'password');
      verify(() => dataSource.signInWithEmailAndPassword('email', 'password'))
          .called(1);
    });

    test('should await signInAccount() method successful', () async {
      when(() => dataSource.signInWithEmailAndPassword('email', 'password'))
          .thenAnswer((_) async => []);
      final results = await sut.signIn(email: 'email', password: 'password');
      expect(results, isA<void>());
    });
  });

  group('signOut', () {
    test('should call rootRemoteDataSource.sugnOut() method', () async {
      when(() => dataSource.signOut()).thenAnswer((_) async => []);
      await sut.signOut();
      verify(() => dataSource.signOut()).called(1);
    });

    test('should await signOut() method successful', () async {
      when(() => dataSource.signOut()).thenAnswer((_) async => []);
      final results = await sut.signOut();
      expect(results, isA<void>());
    });
  });

  group('authStateChanges', () {
    final userController = StreamController<User?>();
    final user = MockUser();

    test('should call rootRemoteDataSource.authStateChanges() method',
        () async {
      when(() => dataSource.authStateChanges())
          .thenAnswer((_) => userController.stream);
      sut.authStateChanges();
      verify(() => dataSource.authStateChanges()).called(1);
    });

    test('authStateChanges emits correct values', () async {
      // Określamy zachowanie atrapy przy wywołaniu authStateChanges()
      when(() => dataSource.authStateChanges())
          .thenAnswer((_) => Stream.fromIterable([
                null, // Initial value when no user is authenticated
                user, // You can create a mock User instance here
                null, // User signed out
              ]));

      // Tworzymy instancję testowanej klasy i przekazujemy atrapę dataSource
      final sut = RootRepository(dataSource);

      // Wywołujemy metodę authStateChanges()
      final stream = sut.authStateChanges();

      // Oczekujemy poprawnych wartości w strumieniu
      expectLater(
        stream,
        emitsInOrder([
          null, // Initial value when no user is authenticated
          isA<User>(), // Check if it's an instance of User or its subclass
          null, // User signed out
        ]),
      );
    });
  });
}
