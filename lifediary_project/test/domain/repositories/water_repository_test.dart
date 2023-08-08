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

  group('saveGlasses', () {
    test('should call waterRemoteDataSource.saveGlassesData() method',
        () async {
      //1
      when(() => dataSource.saveGlassesData('7')).thenAnswer((_) async => []);

      //2
      await sut.saveGlasses('7');
      //3
      verify(() => dataSource.saveGlassesData('7')).called(1);
    });
    test(
      'should return saveGlasses.methos() successful',
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
}
