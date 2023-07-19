import 'package:lifediary_project/app/data/remote_data_sources/stories_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';

class StoriesRepository {
  StoriesRepository(this.storiesRemoteDataSource);

  final StoriesRemoteDataSource storiesRemoteDataSource;

  Future<List<StoriesModel>> getQuotesModel() async {
    final json = await storiesRemoteDataSource.getStories();
    if (json == null) {
      return [];
    }

    return json.map((item) => StoriesModel.fromJson(item)).toList();
  }
}
