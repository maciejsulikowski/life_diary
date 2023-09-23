import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';

void main() {
  test('should create an instance of UserModel', () {
    final userModel = UserModel(id: '1', imageURL: 'imageURL', fullName: 'fullName', storyText: 'storyText');

    expect(userModel, isA<UserModel>());
    expect(userModel.id, equals('1'));
    expect(userModel.imageURL, equals('imageURL'));
    expect(userModel.fullName, equals('fullName'));
    expect(userModel.storyText, equals('storyText'));
  });
}
