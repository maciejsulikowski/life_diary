import 'package:dio/dio.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';
import 'package:retrofit/retrofit.dart';


part 'stories_remote_data_source.g.dart';

@RestApi(
    baseUrl: "https://my-json-server.typicode.com/maciejsulikowski/json-demo")
abstract class StoriesRemoteRetrofitDataSource {
  factory StoriesRemoteRetrofitDataSource(Dio dio, {String baseUrl}) =
      _StoriesRemoteRetrofitDataSource;

  @GET("/stories")
  Future<List<StoriesModel>> getStories();
}


// class StoriesRemoteDioDataSource {
//   Future<List<Map<String, dynamic>>?> getStories() async {
//     final response = await Dio().get<List<dynamic>>(
//         'https://my-json-server.typicode.com/maciejsulikowski/json-demo/stories');
//     final listDynamic = response.data;
//     if (listDynamic == null) {
//       return null;
//     }
//     return listDynamic.map((item) => item as Map<String, dynamic>).toList();
//   }
// }
