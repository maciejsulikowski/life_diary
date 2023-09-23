import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:intl/intl.dart';

void main() {
  test('Should PhotosModel return releaseDate', () {
    //1
    final model = PhotosModel(
        id: '1',
        title: 'title',
        imageURL: 'imageURL',
        releaseDate: DateTime(2023, 7, 6));

    //2
    final results = model.releaseDateFormatted();

    //3

    expect(results,'Thu, Jul 6, 2023');
  });
}
