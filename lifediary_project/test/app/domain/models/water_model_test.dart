import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';

void main() {
  test('should create an instance of WaterModel', () {
    final waterModel = WaterModel(id: '1', glasses: '7');

    expect(waterModel, isA<WaterModel>());
    expect(waterModel.id, equals('1'));
    expect(waterModel.glasses, equals('7'));

  });
}
