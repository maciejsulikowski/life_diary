import 'package:firebase_storage/firebase_storage.dart';
import 'package:lifediary_project/app/data/remote_data_sources/user_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';

class UserRepository {
  UserRepository(this._userRemoteDataSource);

  final UserRemoteDataSource _userRemoteDataSource;

  Stream<UserModel?> getUserData() {
    return _userRemoteDataSource.getUserStream().map(
          (data) => UserModel(
            id: data['id'],
            imageURL: data['image_url'],
            fullName: data['full_name'],
            storyText: data['story_text'],
          ),
        );
  }

  Future<void> add(String imageURL) async {
    return _userRemoteDataSource.add(imageURL);
  }

  Future<void> addFullName(String fullName) async {
    return _userRemoteDataSource.addFullName(fullName);
  }

  Future<void> addStoryText(String storyText) async {
    return _userRemoteDataSource.addStoryText(storyText);
  }

  Future<Reference> pathRef() async {
    return _userRemoteDataSource.pathRef();
  }
}
