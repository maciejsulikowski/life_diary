import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/data/remote_data_sources/user_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockUserDataSource extends Mock implements UserRemoteDataSource {}

class MockReference extends Mock implements Reference {}

void main() {
  late UserRepository sut;
  late MockUserDataSource dataSource;

  setUpAll(() {
    dataSource = MockUserDataSource();
    sut = UserRepository(dataSource);
  });

  group('getUserData', () {
    test('should call _waterRemoteDataSource.getUserStream() method', () {
      final streamController = StreamController<Map<String, dynamic>>();

      //1
      when(() => dataSource.getUserStream())
          .thenAnswer((_) => streamController.stream);
      //2
      sut.getUserData();
      //3
      verify(() => dataSource.getUserStream()).called(1);
    });
    test('should return getUserData() method successful', () {
      final streamController = StreamController<Map<String, dynamic>>();
      final userData = {
        'id': '1',
        'image_url': 'imageURL',
        'full_name': 'Maciej Sulikowski',
        'story_text': 'Done',
      };

      // 1. Stub the dataSource
      when(() => dataSource.getUserStream())
          .thenAnswer((_) => streamController.stream);

      // 2. Get the stream of UserModel
      final results = sut.getUserData();

      // 3. Set up the expectation
      expectLater(
          results,
          emits(UserModel(
            id: '1',
            imageURL: 'imageURL',
            fullName: 'Maciej Sulikowski',
            storyText: 'Done',
          )));

      // 4. Emit data into the stream
      streamController.add(userData);

      // // 6. Close the stream
      streamController.close();
    });
  });

  group('add', () {
    test('should call _userRemoteDataSource.add() method', () async {
      const String imageURL = 'imageURL';

      //1
      when(() => dataSource.add(imageURL)).thenAnswer((_) async => []);
      //2
      await sut.add(imageURL);
      //3
      verify(() => dataSource.add(imageURL)).called(1);
    });
    test('should return add() method successful ', () async {
      String imageURL = 'imageURL';
      //1
      when(() => dataSource.add(imageURL)).thenAnswer((_) async => [imageURL]);
      //2
      final result = await sut.add(imageURL);
      //3
      expect(result, [imageURL]);
    });
  });

  group('addFullName', () {
    test('should call_userRemoteDataSource.addFullName() method', () async {
      const String fullName = 'fullName';

      //1
      when(() => dataSource.addFullName(fullName)).thenAnswer((_) async => []);
      //2
      await sut.addFullName(fullName);
      //3
      verify(() => dataSource.addFullName(fullName)).called(1);
    });
    test('should addFullName() method successful ', () async {
      String fullName = 'fullName';
      //1
      when(() => dataSource.addFullName(fullName))
          .thenAnswer((_) async => [fullName]);
      //2
      final result = await sut.addFullName(fullName);
      //3
      expect(result, [fullName]);
    });
  });
  group('addStoryText', () {
    test('should call _userRemoteDataSource.addStoryText() method', () async {
      const String addStoryText = 'addStoryText';

      //1
      when(() => dataSource.addStoryText(addStoryText))
          .thenAnswer((_) async => []);
      //2
      await sut.addStoryText(addStoryText);
      //3
      verify(() => dataSource.addStoryText(addStoryText)).called(1);
    });
    test('should addStoryText() method successful ', () async {
      String addStoryText = 'addStoryText';
      //1
      when(() => dataSource.addStoryText(addStoryText))
          .thenAnswer((_) async => [addStoryText]);
      //2
      final result = await sut.addStoryText(addStoryText);
      //3
      expect(result, [addStoryText]);
    });
  });
  group('pathRef', () {
    test('should call _userRemoteDataSource.pathRef() method', () async {
      final expectedReference = MockReference();

      //1
      when(() => dataSource.pathRef())
          .thenAnswer((_) async => expectedReference);
      //2
      await sut.pathRef();
      //3
      verify(() => dataSource.pathRef()).called(1);
    });
    test('should pathRef() method successful ', () async {
      final expectedReference = MockReference();
      //1
      when(() => dataSource.pathRef())
          .thenAnswer((_) async => expectedReference);
      //2
      final result = await sut.pathRef();
      //3
      expect(result, expectedReference);
    });
  });
}
