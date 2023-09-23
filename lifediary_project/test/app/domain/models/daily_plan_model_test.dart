import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

void main() {
  test('should create an instance of UserModel', () {
    final dailyPlanModel = DailyPlanModel(
        id: '1',
        text: 'text',
        time: 'time');

    expect(dailyPlanModel, isA<DailyPlanModel>());
    expect(dailyPlanModel.id, equals('1'));
    expect(dailyPlanModel.text, equals('text'));
    expect(dailyPlanModel.time, equals('time'));
  });
}
