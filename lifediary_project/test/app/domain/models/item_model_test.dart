import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:intl/intl.dart';

void main() {
  test('Should return releaseDateFormatted', () {
    //1
    final model = ItemModel(
        id: '1',
        title: 'title',
        imageURL: 'imageURL',
        releaseDate: DateTime(2023, 7, 6),
        text: []);

    //2
    final results = model.releaseDateFormatted();
    //3
    expect(results, 'Thu, Jul 6, 2023');
  });

  test('Should return correct number of days', () {
    //1
    final releaseDate = DateTime.now().add(const Duration(days: 7));
    final model = ItemModel(
        id: '1',
        title: 'title',
        imageURL: 'imageURL',
        releaseDate: releaseDate,
        text: []);

    //2
    final results = model.daysLeft();
    //3
    expect(results, '7');
  });

  
}
