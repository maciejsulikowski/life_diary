import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/domain/models/weather_model.dart';

void main() {
  test("should getter return temperature with °C combined", () {
    //1
    final model = CurrentCondition(temp_c: 10.5);

    //2
    final result = model.temp;

    //3
    expect(result, '10.5 °C');
  });
}
