import 'package:lifediary_project/app/data/remote_data_sources/stories_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';

class StoriesRepository {
  StoriesRepository(this.storiesRemoteDataSource);

  final StoriesRemoteDioDataSource storiesRemoteDataSource;

  Future<List<StoriesModel>> getStoriesModel(int authorID) async {
    final json = await storiesRemoteDataSource.getStories();
    if (json == null) {
      return [];
    }

    final allStories = json.map((item) => StoriesModel.fromJson(item)).toList();

    return allStories.where((element) => element.authorID == authorID).toList();
  }
}
