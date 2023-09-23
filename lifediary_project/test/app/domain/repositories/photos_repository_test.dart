import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/data/remote_data_sources/photos_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/repositories/photos_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotosDataSource extends Mock implements PhotosRemoteDataSource {}

class MockReference extends Mock implements Reference {}
void main() {
  late MockPhotosDataSource dataSource;
  late PhotosRepository sut;

  setUp(() {
    dataSource = MockPhotosDataSource();
    sut = PhotosRepository(dataSource);
  });

  group('getPhotosStream', () {
    final streamController = StreamController<List<Map<String, dynamic>>>();
    final photoData = [
      {
        'id': '1',
        'title': 'title',
        'image_url': 'imageURL',
        'release_date': Timestamp.fromDate(DateTime(2023, 7, 6)),
        'height': 'height',
        'weight': 'weight',
        'goals': 'goals'
      }
    ];
    test('should call _photosRemoteDataSource.getPhotosData() method', () {
      when(() => dataSource.getPhotosData())
          .thenAnswer((_) => streamController.stream);
      //2
      sut.getPhotosStream();
      //3
      verify(() => dataSource.getPhotosData()).called(1);
    });

    test('should return getPhotosStream() method successful', () {
      when(() => dataSource.getPhotosData())
          .thenAnswer((_) => streamController.stream);
      //2
      final result = sut.getPhotosStream();
      //3
      expectLater(
          result,
          emits({
            PhotosModel(
              id: '1',
              title: 'title',
              imageURL: 'imageURL',
              releaseDate: DateTime(2023, 7, 6),
              height: 'height',
              weight: 'weight',
              goals: 'goals',
            )
          }));
      //4
      streamController.add(photoData);
      //5
      streamController.close();
    });
  });

  group('savePhotoData', () {
    test('should call _photosRemoteDataSource.savePhotoData() method',
        () async {
      //1
      when(() => dataSource.savePhotoData('1', 'weight', 'height', 'goals'))
          .thenAnswer((_) async => []);
      //2
      await sut.savePhotoData('1', 'weight', 'height', 'goals');
      //3
      verify(() => dataSource.savePhotoData('1', 'weight', 'height', 'goals'))
          .called(1);
    });

    test('should return savePhotoData() method successful', () async {
      //1
      when(() => dataSource.savePhotoData('1', 'weight', 'height', 'goals'))
          .thenAnswer((_) async => [
                PhotosModel(
                    id: '1',
                    title: 'title',
                    imageURL: 'imageURL',
                    releaseDate: DateTime(2023, 7, 6))
              ]);
      //2
      final result = await sut.savePhotoData('1', 'weight', 'height', 'goals');
      //3
      expect(result, [
        PhotosModel(
            id: '1',
            title: 'title',
            imageURL: 'imageURL',
            releaseDate: DateTime(2023, 7, 6))
      ]);
    });
  });
  group('deletephoto', () {
    String photoID = '1';
    test('should call _photosRemoteDataSource.deletephoto() method', () async {
      when(() => dataSource.deletephoto(id: photoID))
          .thenAnswer((_) async => []);

      await sut.deletephoto(id: photoID);
      verify(() => dataSource.deletephoto(id: photoID)).called(1);
    });
    test('should return deletephoto() successful', () async {
      when(() => dataSource.deletephoto(id: photoID)).thenAnswer((_) async => [
            PhotosModel(
              id: '1',
              title: 'title',
              imageURL: 'imageURL',
              releaseDate: DateTime(2023, 7, 6),
              height: 'height',
              weight: 'weight',
              goals: 'goals',
            )
          ]);

      final results = await sut.deletephoto(id: photoID);
      expect(results, [
        PhotosModel(
          id: '1',
          title: 'title',
          imageURL: 'imageURL',
          releaseDate: DateTime(2023, 7, 6),
          height: 'height',
          weight: 'weight',
          goals: 'goals',
        )
      ]);
    });
  });

  group('getphotos', () {
    String photoID = '1';
    test('should call _photosRemoteDataSource.getphotos() method', () async {
      when(() => dataSource.getphotos(id: photoID)).thenAnswer((_) async => {
            'id': '1',
            'title': 'title',
            'image_url': 'imageURL',
            'release_date': Timestamp.fromDate(DateTime(2023, 7, 6)),
            'height': 'height',
            'weight': 'weight',
            'goals': 'goals',
          });

      await sut.getphotos(id: photoID);
      verify(() => dataSource.getphotos(id: photoID)).called(1);
    });
    test('should return getphotos() successful', () async {
      when(() => dataSource.getphotos(id: photoID)).thenAnswer((_) async => {
            'id': '1',
            'title': 'title',
            'image_url': 'imageURL',
            'release_date': Timestamp.fromDate(DateTime(2023, 7, 6)),
            'height': 'height',
            'weight': 'weight',
            'goals': 'goals',
          });

      final results = await sut.getphotos(id: photoID);
      expect(
          results,
          PhotosModel(
            id: '1',
            title: 'title',
            imageURL: 'imageURL',
            releaseDate: DateTime(2023, 7, 6),
            height: 'height',
            weight: 'weight',
            goals: 'goals',
          ));
    });
  });

  group('addphoto', () {
    test('should call _photosRemoteDataSource.addphoto() method', () async {
      when(() => dataSource.addphoto(
            'title',
            'imageURL',
            DateTime(2023, 7, 6),
            'weight',
            'height',
            'goals',
          )).thenAnswer((_) async => []);

      await sut.addphoto(
        'title',
        'imageURL',
        DateTime(2023, 7, 6),
        'weight',
        'height',
        'goals',
      );
      verify(() => dataSource.addphoto(
            'title',
            'imageURL',
            DateTime(2023, 7, 6),
            'weight',
            'height',
            'goals',
          )).called(1);
    });
    test('should return addphoto() successful', () async {
      when(() => dataSource.addphoto(
            'title',
            'imageURL',
            DateTime(2023, 7, 6),
            'weight',
            'height',
            'goals',
          )).thenAnswer((_) async => 
            PhotosModel(
              id: '1',
              title: 'title',
              imageURL: 'imageURL',
              releaseDate: DateTime(2023, 7, 6),
              height: 'height',
              weight: 'weight',
              goals: 'goals',
            )
          );

      final results = await sut.addphoto(
        'title',
        'imageURL',
        DateTime(2023, 7, 6),
        'weight',
        'height',
        'goals',
      );
      expect(
          results,
          PhotosModel(
            id: '1',
            title: 'title',
            imageURL: 'imageURL',
            releaseDate: DateTime(2023, 7, 6),
            height: 'height',
            weight: 'weight',
            goals: 'goals',
          ));
    });
  });

  group('pathRef', () {
    test('should call _photosRemoteDataSource.pathRef() method', () async {
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
