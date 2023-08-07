import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:intl/intl.dart';

void main() {
  test('', () {
    //1
    final model = ItemModel(
        id: '1',
        title: 'title',
        imageURL: 'imageURL',
        releaseDate: DateFormat('yMMMEd').parse('Thu, Jul 6, 2023'),
        text: []);

    //2
    final results = model.releaseDateFormatted();
    //3
  });
}
