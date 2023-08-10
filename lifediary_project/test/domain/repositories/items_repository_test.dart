import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/data/remote_data_sources/items_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsDataSource extends Mock implements ItemsRemoteDataSource {}

class MockReference extends Mock implements Reference {}

void main() {
  late MockItemsDataSource dataSource;
  late ItemsRepository sut;

  setUp(() {
    dataSource = MockItemsDataSource();
    sut = ItemsRepository(dataSource);
  });

  group('getItemsStream', () {
    final streamController = StreamController<List<Map<String, dynamic>>>();
    final itemData = [
      {
        'id': '1',
        'title': 'title',
        'image_url': 'imageURL',
        'release_date': Timestamp.fromDate(DateTime(2023, 7, 6)),
        'text': [],
      }
    ];
    test('should call _itemsRemoteDataSource.getItemsData() method', () {
      when(() => dataSource.getItemsData())
          .thenAnswer((_) => streamController.stream);
      //2
      sut.getItemsStream();
      //3
      verify(() => dataSource.getItemsData()).called(1);
    });

    test('should return getItemsStream successful', () {
      when(() => dataSource.getItemsData())
          .thenAnswer((_) => streamController.stream);
      //2
      final result = sut.getItemsStream();
      //3
      expectLater(
          result,
          emits({
            ItemModel(
              id: '1',
              title: 'title',
              imageURL: 'imageURL',
              releaseDate: DateTime(2023, 7, 6),
              text: [],
            )
          }));
      //4
      streamController.add(itemData);
      //5
      streamController.close();
    });

    group('delete', () {
      String photoID = '1';
      test('should call _itemsRemoteDataSource.delete() method',
          () async {
        when(() => dataSource.delete(id: photoID))
            .thenAnswer((_) async => []);

        await sut.delete(id: photoID);
        verify(() => dataSource.delete(id: photoID)).called(1);
      });
      test('should return delete() successful', () async {
        when(() => dataSource.delete(id: photoID))
            .thenAnswer((_) async => [
                  ItemModel(
                    id: '1',
                    title: 'title',
                    imageURL: 'imageURL',
                    releaseDate: DateTime(2023, 7, 6),
                    text: [],
                  )
                ]);

        final results = await sut.delete(id: photoID);
        expect(results, [
          ItemModel(
            id: '1',
            title: 'title',
            imageURL: 'imageURL',
            releaseDate: DateTime(2023, 7, 6),
            text: [],
          )
        ]);
      });
    });
  });
  group('get', () {
    String photoID = '1';
    test('should call _itemsRemoteDataSource.get() method', () async {
      when(() => dataSource.get(id: photoID)).thenAnswer((_) async => {
            'id': '1',
            'title': 'title',
            'image_url': 'imageURL',
            'release_date': Timestamp.fromDate(DateTime(2023, 7, 6)),
            'text': [],
          });

      await sut.get(id: photoID);
      verify(() => dataSource.get(id: photoID)).called(1);
    });
    test('should return get() successful', () async {
      when(() => dataSource.get(id: photoID)).thenAnswer((_) async => {
            'id': '1',
            'title': 'title',
            'image_url': 'imageURL',
            'release_date': Timestamp.fromDate(DateTime(2023, 7, 6)),
            'text' : [],
          });

      final results = await sut.get(id: photoID);
      expect(
          results,
          ItemModel(
            id: '1',
            title: 'title',
            imageURL: 'imageURL',
            releaseDate: DateTime(2023, 7, 6),
            text: [],
          ));
    });
  });

  group('add', () {
    final delta = Delta()..insert('Hello world!');
    test('should call _itemsRemoteDataSource.add() method', () async {
      when(() => dataSource.add(
            'title',
            'imageURL',
            DateTime(2023, 7, 6),
            delta,
            1,
          )).thenAnswer((_) async => []);

      await sut.add(
        'title',
        'imageURL',
        DateTime(2023, 7, 6),
        delta,
        1
      );
      verify(() => dataSource.add(
            'title',
            'imageURL',
            DateTime(2023, 7, 6),
            delta,
            1
          )).called(1);
    });
    test('should return add() method successful', () async {
      when(() => dataSource.add(
            'title',
            'imageURL',
            DateTime(2023, 7, 6),
            delta,
            1
          )).thenAnswer((_) async => ItemModel(
            id: '1',
            title: 'title',
            imageURL: 'imageURL',
            releaseDate: DateTime(2023, 7, 6),
            text: [],
          ));

      final results = await sut.add(
        'title',
        'imageURL',
        DateTime(2023, 7, 6),
        delta,
        1,
      );
      expect(
          results,
          ItemModel(
            id: '1',
            title: 'title',
            imageURL: 'imageURL',
            releaseDate: DateTime(2023, 7, 6),
            text: [],
          ));
    });
  });

  group('addtext', () {
    final delta = Delta()..insert('Hello world!');
    test('should call _itemsRemoteDataSource.addtext() method', () async {
      when(() => dataSource.addtext(
            '1',
            delta,
            
          )).thenAnswer((_) async => []);

      await sut.addtext('1', delta);
      verify(() => dataSource.addtext(
          '1', delta)).called(1);
    });
    test('should return addtext() method successful', () async {
      when(() => dataSource.addtext(
              '1', delta))
          .thenAnswer((_) async => ItemModel(
                id: '1',
                title: 'title',
                imageURL: 'imageURL',
                releaseDate: DateTime(2023, 7, 6),
                text: delta.toList(),
              ));

      final results = await sut.addtext(
        '1',
        delta,
        
      );
      expect(
          results,
          ItemModel(
            id: '1',
            title: 'title',
            imageURL: 'imageURL',
            releaseDate: DateTime(2023, 7, 6),
            text: delta.toList(),
          ));
    });
  });

  group('pathRef', () {
    test('should call itemsRemoteDataSource.pathRef() method', () async {
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
