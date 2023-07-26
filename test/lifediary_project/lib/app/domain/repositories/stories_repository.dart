import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/data/remote_data_sources/stories_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';



@injectable
class StoriesRepository {
  StoriesRepository(this.storiesRemoteDataSource);

  final StoriesRemoteRetrofitDataSource storiesRemoteDataSource;

  Future<List<StoriesModel>> getStoriesModel(int authorID) async {
    final allStories = await storiesRemoteDataSource.getStories();

    return allStories.where((element) => element.authorID == authorID).toList();
  }
}
