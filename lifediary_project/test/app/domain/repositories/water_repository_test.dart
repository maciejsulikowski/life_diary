import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/data/remote_data_sources/water_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/domain/repositories/water_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockWaterDataSource extends Mock implements WaterRemoteDataSource {}

void main() {
  late WaterRepository sut;

  late MockWaterDataSource dataSource;

  setUp(() {
    dataSource = MockWaterDataSource();
    sut = WaterRepository(dataSource);
  });

  group('getGlassesStream', () {
    test('should call _waterRemoteDataSource.getGlassesData() method', () {
      final streamController = StreamController<Map<String, dynamic>>();

      //1
      when(() => dataSource.getGlassesData())
          .thenAnswer((_) => streamController.stream);
      //2
      sut.getGlassesStream();
      //3
      verify(() => dataSource.getGlassesData()).called(1);
    });
    test('should return getGlassesStream() method successful', () {
      final streamController = StreamController<Map<String, dynamic>>();
      final waterData = {'id': '1', 'glasses': '7'};
      //1
      when(() => dataSource.getGlassesData())
          .thenAnswer((_) => streamController.stream);
      //2
      final results = sut.getGlassesStream();
      //3 Use expectLater to test the stream
      expectLater(results, emits(WaterModel(id: '1', glasses: '7')));
      //4 Add waterData to the stream
      streamController.add(waterData);
      //5 Close the stream controller to complete the stream
      streamController.close();
    });
  });
  group('saveGlasses', () {
    test('should call _waterRemoteDataSource.saveGlassesData() method',
        () async {
      //1
      when(() => dataSource.saveGlassesData('7')).thenAnswer((_) async => []);

      //2
      await sut.saveGlasses('7');
      //3
      verify(() => dataSource.saveGlassesData('7')).called(1);
    });
    test(
      'should return saveGlasses.method() successful',
      () async {
        //1
        when(() => dataSource.saveGlassesData('7')).thenAnswer((_) async => [
              WaterModel(id: '1', glasses: '7'),
              WaterModel(id: '2', glasses: '6')
            ]);
        //2
        final results = await sut.saveGlasses('7');
        //3
        expect(results, [
          WaterModel(id: '1', glasses: '7'),
          WaterModel(id: '2', glasses: '6')
        ]);
      },
    );
  });

  group('getGlasses', () {
    test('should call _waterRemoteDataSource.getGlasses() method', () async {
      String expectedId = '1';
      //1
      when(() => dataSource.getGlasses(id: expectedId))
          .thenAnswer((_) async => {'id': '1', 'glasses': '7'});
      //2
      await sut.getGlasses(id: expectedId);
      //3
      verify(() => dataSource.getGlasses(id: expectedId)).called(1);
    });
    test('should return getGlasses method() successful', () async {
      String expectedId = '1';
      String expectedGlasses = '7';
      //1
      when(() => dataSource.getGlasses(id: expectedId)).thenAnswer(
          (_) async => {'id': expectedId, 'glasses': expectedGlasses});
      //2
      final results = await sut.getGlasses(id: expectedId);
      //3
      expect(results, WaterModel(id: expectedId, glasses: expectedGlasses));
    });
  });
}
